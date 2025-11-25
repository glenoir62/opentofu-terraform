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