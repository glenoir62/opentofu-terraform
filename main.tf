resource "local_file" "index" {
  filename = "${path.module}/index.html"
  content  = "<html><body><h1>Bienvenue GLEO</h1></body></html>"
}


resource "local_file" "texte" {
  filename = "${path.module}/exemple.txt"
  content  = "Contenu généré automatiquement."
}

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
  mounts {
    target = "/usr/share/nginx/html/index.html"
    source = abspath(local_file.index.filename)
    type   = "bind"
  }
}
