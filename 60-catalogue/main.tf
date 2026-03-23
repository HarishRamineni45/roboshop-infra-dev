# creating EC2 instance for catalogue service to create AMI with code changes and use that AMI in launch template to launch instances in ASG with latest code changes
resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.private_subnet_id
  vpc_security_group_ids = [local.catalogue_sg_id]

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source      = "bootstrap.sh" # Local file path
    destination = "/tmp/bootstrap.sh"    # Destination path on the remote machine
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh catalogue ${var.environment}"
    ]
  }
}

# stopping the instance to create AMI, as creating AMI from running instance will fail with error, "cannot create image when instance is running"
resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state =  "stopped"
  depends_on = [terraform_data.catalogue]
}

# creating AMI instance from catalogue services
resource "aws_ami_from_instance" "catalogue" {
  name               = "${var.project}-${var.environment}-catalogue"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [aws_ec2_instance_state.catalogue]
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}

# creating target group for catalogue service, which will be used in ASG and ALB target group attachment
resource "aws_lb_target_group" "catalogue" {
  name     = "${var.project}-${var.environment}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60
  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 10
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 3
    port                = 8080
  }
}

# creating launch template for catalogue service, which will be used in ASG to launch instances with the latest AMI having code changes

resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"

  image_id = aws_ami_from_instance.catalogue.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"

  vpc_security_group_ids = [local.catalogue_sg_id]
  # each time when terraform apply is run, new AMI will be created and the launch template will be updated with the new AMI, which will trigger replacement of ASG instances and they will be launched with the new AMI having latest code changes and select it as default version of the launch template
  update_default_version = true

  # tags for instances created from the launch template through ASG

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      {
        Name = "${var.project}-${var.environment}-catalogue"
      },
      local.common_tags
    )
  }
  
  # tags for volumes created from the launch template 
  tag_specifications {
    resource_type = "volume"

    tags = merge(
      {
        Name = "${var.project}-${var.environment}-catalogue"
      },
      local.common_tags
    )
  }
  # tags for launch template itself
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-catalogue"
    },
    local.common_tags
  )
}
 # creating autoscaling group with instances


