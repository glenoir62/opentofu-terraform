locals {
  app_api_key_from_sm = jsondecode(data.aws_secretsmanager_secret_version.app_api_key_secret.secret_string)["my_app_api_key"]
}