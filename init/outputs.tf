/*
terraform output -json
terraform output -raw nom_de_l_output
terraform output
 */

output "internal_port" {
  value       = "http://localhost:${var.internal_port}"
  description = "URL internal_port du conteneur nginx"
}

output "external_port" {
  value       = "http://localhost:${var.external_port}"
  description = "URL external_port du conteneur nginx"
}

output "contenu_du_fichier" {
  value = data.local_file.html.content
}

output "serveurs" {
  value = join(", ", ["web1", "web2", "web3"])
}

output "liste_serveurs" {
  value = split(", ", "web1, web2, web3")
  sensitive   = true
}

output "uppercase" {
  value = upper("production")
}

output "valeur_max" {
  value = max(3, 8, 5)
}

output "positif" {
  value = abs(-42)
}

output "nb_zones" {
  value = length(var.zones)
}

output "zone_disponible" {
  value = contains(var.zones, "us-east-1b")
}

output "niveau" {
  value = lookup(var.roles, "admin", "lecture-seule")
}

output "map_complete" {
  value = merge(
    { "env" = "prod" },
    { "tier" = "frontend" }
  )
}

output "date_heure" {
  value = timestamp()
}

output "expiration" {
  value = timeadd(timestamp(), "72h")
}

output "date_simple" {
  value = formatdate("YYYY-MM-DD", timestamp())
}

output "urlTest" {
  value = "https://${lower(var.utilisateur.nom)}.example.com"
}