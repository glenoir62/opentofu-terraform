output "web_server_public_ip" {
  description = "Adresse IP publique de l'instance EC2 NGINX."
  value       = module.serveur_web_1.public_ip # Référence la sortie du module
}

output "web_server_instance_id" {
  description = "ID de l'instance EC2 NGINX."
  value       = module.serveur_web_1.instance_id # Référence la sortie du module
}