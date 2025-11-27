## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | ~> 3.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.9.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.6.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker_container.web](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker_image.nginx](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [null_resource.generate_config](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [local_file.html](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Nom du conteneur Docker | `string` | `"nginx_container"` | no |
| <a name="input_coordonnees"></a> [coordonnees](#input\_coordonnees) | n/a | `tuple([number, number])` | <pre>[<br/>  48.8584,<br/>  2.2945<br/>]</pre> | no |
| <a name="input_external_port"></a> [external\_port](#input\_external\_port) | Port externe mappé sur l'hôte | `number` | `8080` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Nom de l'image Docker à utiliser | `string` | `"nginx:latest"` | no |
| <a name="input_images"></a> [images](#input\_images) | n/a | `map(string)` | <pre>{<br/>  "centos": "ami-789012",<br/>  "ubuntu": "ami-123456"<br/>}</pre> | no |
| <a name="input_internal_port"></a> [internal\_port](#input\_internal\_port) | Port interne exposé par le conteneur | `number` | `80` | no |
| <a name="input_nom_serveur"></a> [nom\_serveur](#input\_nom\_serveur) | n/a | `string` | `"web-01"` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | n/a | `map(string)` | <pre>{<br/>  "admin": "ecriture",<br/>  "lecture-seule": "lecture-seule",<br/>  "user": "lecture-seule"<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `set(string)` | <pre>[<br/>  "web",<br/>  "production",<br/>  "secure"<br/>]</pre> | no |
| <a name="input_utilisateur"></a> [utilisateur](#input\_utilisateur) | n/a | <pre>object({<br/>    nom    = string<br/>    actif  = bool<br/>    niveau = number<br/>  })</pre> | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | n/a | `list(string)` | <pre>[<br/>  "us-east-1a",<br/>  "us-east-1b",<br/>  "us-east-1c"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_contenu_du_fichier"></a> [contenu\_du\_fichier](#output\_contenu\_du\_fichier) | n/a |
| <a name="output_date_heure"></a> [date\_heure](#output\_date\_heure) | n/a |
| <a name="output_date_simple"></a> [date\_simple](#output\_date\_simple) | n/a |
| <a name="output_expiration"></a> [expiration](#output\_expiration) | n/a |
| <a name="output_external_port"></a> [external\_port](#output\_external\_port) | URL external\_port du conteneur nginx |
| <a name="output_internal_port"></a> [internal\_port](#output\_internal\_port) | URL internal\_port du conteneur nginx |
| <a name="output_liste_serveurs"></a> [liste\_serveurs](#output\_liste\_serveurs) | n/a |
| <a name="output_map_complete"></a> [map\_complete](#output\_map\_complete) | n/a |
| <a name="output_nb_zones"></a> [nb\_zones](#output\_nb\_zones) | n/a |
| <a name="output_niveau"></a> [niveau](#output\_niveau) | n/a |
| <a name="output_positif"></a> [positif](#output\_positif) | n/a |
| <a name="output_serveurs"></a> [serveurs](#output\_serveurs) | n/a |
| <a name="output_uppercase"></a> [uppercase](#output\_uppercase) | n/a |
| <a name="output_urlTest"></a> [urlTest](#output\_urlTest) | n/a |
| <a name="output_valeur_max"></a> [valeur\_max](#output\_valeur\_max) | n/a |
| <a name="output_zone_disponible"></a> [zone\_disponible](#output\_zone\_disponible) | n/a |
