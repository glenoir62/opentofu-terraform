resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "web" {
  image = docker_image.nginx.image_id
  name  = "web-nginx"
  ports {
    internal = 80
    external = var.container_port
  }
}

// Ressource local_file
resource "local_file" "texte" {
  filename = "${path.module}/exemple.txt"
  content  = "Contenu généré automatiquement."
}

resource "local_file" "page" {
  filename = "${path.module}/index.html"
  content  = "<h1>Bienvenue</h1>"
}

resource "local_file" "exemple" {
  filename             = "${path.module}/fichier.txt"
  content              = "Texte généré"
  file_permission      = "0644"
  directory_permission = "0755"
  sensitive_content    = "données critiques"
}