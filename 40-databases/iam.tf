resource "aws_iam_role" "mysql" {
  name = local.mysql_role_name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
        Name = local.mysql_role_name
    },
      local.common_tags
  )
}

resource "aws_iam_policy" "mysql" {
   name        = "${random_pet.pet_name.id}-policy"
   description = "A policy for MySQL EC2 instance to access SSM parameters"
   policy = file("mysql-iam-policy.json")
}