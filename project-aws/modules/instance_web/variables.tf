variable "ami_id" {
  description = "L'ID de l'AMI à utiliser pour l'instance EC2."
  type        = string
}

variable "instance_type" {
  description = "Le type d'instance EC2."
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Nom du projet pour les tags."
  type        = string
}

variable "environment_tag" {
  description = "Tag d'environnement."
  type        = string
}