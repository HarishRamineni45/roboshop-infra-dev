resource "aws_security_group_rule" "bastion_internet" {      # Bastion is accessed from Internet
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = ["0.0.0.0/0"]
  cidr_blocks       = [local.my_ip]
  security_group_id = local.bastion_sg_id   # which SG you are creating this rule
}

resource "aws_security_group_rule" "mongodb_bastion" {      # MongoDB is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id   # Where traffic is coming from
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {       # MongoDB is accessed by Catalogue service
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = local.catalogue_sg_id   # Where traffic is coming from
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "mongodb_user" {    # MongoDB is accessed by User service
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = local.user_sg_id  # Where traffic is coming from
  security_group_id = local.mongodb_sg_id
}

resource "aws_security_group_rule" "redis_bastion" {    # Redis is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id    # Where traffic is coming from
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_cart" {    # Redis is accessed by Cart service
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp" 
  source_security_group_id = local.cart_sg_id  # Where traffic is coming from
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_user" {        # Redis is accessed by User service
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  source_security_group_id = local.user_sg_id  # Where traffic is coming from
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "mysql_bastion" {    # MySQL is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.mysql_sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {       # MySQL is accessed by Shipping service
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = local.shipping_sg_id  # Where traffic is coming from
  security_group_id = local.mysql_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion" {         # RabbitMQ is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {         # RabbitMQ is accessed by Payment service
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  source_security_group_id = local.payment_sg_id   # Where traffic is coming from
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "catalogue_bastion" {          # Catalogue service is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "catalogue_backend_alb" {        # Catalogue service is accessed by Backend ALB
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = local.backend_alb_sg_id  # Where traffic is coming from
  security_group_id = local.catalogue_sg_id
}

resource "aws_security_group_rule" "user_bastion" {          # User service is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.user_sg_id
}

resource "aws_security_group_rule" "user_backend_alb" {          # User service is accessed by Backend ALB
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080  
  protocol          = "tcp"
  source_security_group_id = local.backend_alb_sg_id  # Where traffic is coming from
  security_group_id = local.user_sg_id
}

resource "aws_security_group_rule" "cart_bastion" {          # Cart service is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.cart_sg_id
}

resource "aws_security_group_rule" "cart_backend_alb" {          # Cart service is accessed by Backend ALB
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080  
  protocol          = "tcp"
  source_security_group_id = local.backend_alb_sg_id  # Where traffic is coming from
  security_group_id = local.cart_sg_id
}

resource "aws_security_group_rule" "shipping_bastion" {          # Shipping service is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.shipping_sg_id
}

resource "aws_security_group_rule" "shipping_backend_alb" {          # Shipping service is accessed by Backend ALB
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080  
  protocol          = "tcp"
  source_security_group_id = local.backend_alb_sg_id  # Where traffic is coming from
  security_group_id = local.shipping_sg_id
}

resource "aws_security_group_rule" "payment_bastion" {          # Payment service is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.payment_sg_id
}

resource "aws_security_group_rule" "payment_backend_alb" {          # Payment service is accessed by Backend ALB
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080  
  protocol          = "tcp"
  source_security_group_id = local.backend_alb_sg_id  # Where traffic is coming from
  security_group_id = local.payment_sg_id
}

resource "aws_security_group_rule" "backend_alb_bastion" {          # Backend ALB is accessed by Bastion
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_catalogue" {          # Backend ALB is accessed by Catalogue
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.catalogue_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_user" {          # Backend ALB is accessed by User
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.user_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {          # Backend ALB is accessed by Cart
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.cart_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {          # Backend ALB is accessed by Shipping
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.shipping_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_payment" {          # Backend ALB is accessed by Payment
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.payment_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_frontend" {          # Backend ALB is accessed by Frontend
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.frontend_sg_id  # Where traffic is coming from
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "frontend_bastion" {          #  frontend is accessed by Bastion
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = local.bastion_sg_id  # Where traffic is coming from
  security_group_id = local.frontend_sg_id
}

resource "aws_security_group_rule" "frontend_frontend_alb" {          # Frontend is accessed by Frontend ALB
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = local.frontend_alb_sg_id  # Where traffic is coming from
  security_group_id = local.frontend_sg_id
}

resource "aws_security_group_rule" "frontend_alb_public" {          # Frontend ALB is accessed by Internet/Public
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.frontend_alb_sg_id    # Where traffic is coming from
}

# open VPN
resource "aws_security_group_rule" "OpenVpn_public_443" {          # openvpn is accessed by Internet/Public
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id    # Where traffic is coming from
}

# Admin UI
resource "aws_security_group_rule" "OpenVpn_public_943" {          # openvpn is accessed by Internet/Public
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id    # Where traffic is coming from
}




