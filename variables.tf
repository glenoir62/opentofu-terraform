variable "image_name" {
  type        = string
  description = "Nom de l'image Docker à utiliser"
  default     = "nginx:latest"
  validation {
    condition     = can(regex("^.+:.+$", var.image_name)) || startswith(var.image_name, "nginx")
    error_message = "L'image doit avoir un format valide (nom[:tag])"
  }
}

variable "container_name" {
  type        = string
  description = "Nom du conteneur Docker"
  default     = "nginx_container"
  validation {
    condition     = length(var.container_name) >= 3
    error_message = "Le nom du conteneur doit contenir au moins 3 caractères"
  }
}

variable "internal_port" {
  type        = number
  description = "Port interne exposé par le conteneur"
  default     = 80
  validation {
    condition     = var.internal_port > 0 && var.internal_port < 65536
    error_message = "Le port interne doit être compris entre 1 et 65535"
  }
}

variable "external_port" {
  type        = number
  description = "Port externe mappé sur l'hôte"
  default     = 8080
  validation {
    condition     = var.external_port > 0 && var.external_port < 65536
    error_message = "Le port externe doit être compris entre 1 et 65535"
  }
}

variable "nom_serveur" {
  type    = string
  default = "web-01"
}

variable "roles" {
  type = map(string)
  default = {
    "user"          = "lecture-seule"
    "admin"         = "ecriture"
    "lecture-seule" = "lecture-seule"
  }
}


variable "zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "images" {
  type = map(string)
  default = {
    "ubuntu" = "ami-123456",
    "centos" = "ami-789012"
  }
}

variable "tags" {
  type    = set(string)
  default = ["web", "production", "secure"]
}

variable "utilisateur" {
  type = object({
    nom    = string
    actif  = bool
    niveau = number
  })

  validation {
    //condition     = alltrue([for p in var.ports_autorises : p >= 1024 && p <= 65535])
    //condition     = can(regex("^[a-z]+$", var.nom_projet))
    //condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    //condition     = can(regex("^.+@.+$", var.email_contact))
    condition     = var.utilisateur.nom == "GLEO"
    error_message = "La variable validation_test doit être exactement 'ok'"
  }
}

variable "coordonnees" {
  type    = tuple([number, number])
  default = [48.8584, 2.2945]
  sensitive   = true
}
