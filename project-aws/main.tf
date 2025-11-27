data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region // Utilisation de la variable
  profile = "projet1-sso"
}


# Appel de notre module local 'instance_web'
module "serveur_web_1" {
  source = "./modules/instance_web" # Chemin vers notre module

  ami_id          = data.aws_ami.amazon_linux_2023.id
  instance_type   = var.instance_type # Utilise la variable définie dans le variables.tf racine
  project_name    = var.project_name
  environment_tag = var.environment_tag
}

# Vous pourriez même appeler le module une seconde fois pour créer un autre serveur !
# module "serveur_web_2" {
#   source = "./modules/instance_web"
#
#   ami_id        = data.aws_ami.amazon_linux_2023.id
#   instance_type = "t3.small" # Type différent
#   project_name  = var.project_name
#   environment_tag = "Staging" # Environnement différent
# }