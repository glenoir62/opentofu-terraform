output "url" {
  value       = "http://localhost:${var.container_port}"
  description = "URL locale du conteneur nginx"
}

output "contenu_du_fichier" {
  value = data.local_file.html.content
}