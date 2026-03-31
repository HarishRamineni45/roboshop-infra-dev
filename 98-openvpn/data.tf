data "aws_ami" "openvpn" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-3b5882c4-551b-43fa-acfe-7f5cdb896ff1"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "openvpn_sg_id" {
  name = "/${var.project}/${var.environment}/openvpn_sg_id"
}