# Reads the information from the remote statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "b55-terraform-bucket"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region  = "us-east-1" 
  }
}

# Reads the information from the remote ALB statefile

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket  = "b55-terraform-bucket"
    key    = "alb/${var.ENV}/terraform.tfstate"
    region  = "us-east-1" 
  }
}


# Fetches the information of the secrets

data "aws_secretsmanager_secret" "secrets" {
    name = "robot/secrets"
}

#Fetches the secret version from the above server
data "aws_secretsmanager_secret_version" "secret_version" {
    secret_id = data.aws_secretsmanager_secret.secrets.id
}

#Datasource to fetch the info of AMI

data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "b55-chinna-lab-image"
  owners           = ["self"]
}

