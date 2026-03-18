module "vpc" {
    source = "git::https://github.com/HarishRamineni45/terraform-aws-vpc.git?ref=main"
    project = var.project
    environment = var.environment
    is_peering_required = true
}