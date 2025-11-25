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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker_container.web](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker_image.nginx](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [local_file.index](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.texte](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port exposé sur la machine hôte | `number` | `8000` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | URL locale du conteneur nginx |
