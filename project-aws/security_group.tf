// aws ec2 get-console-output --instance-id i-0a9...web_server_instance_id --profile projet1-sso

resource "aws_security_group" "web_sg" {
  name        = "web-sg-${var.project_name}-${lower(var.environment_tag)}"
  description = "Allow HTTP inbound traffic for ${var.project_name} NGINX WebServer"

  ingress {
    description      = "HTTP from anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "WebServer-NGINX-SG-${var.project_name}"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = var.environment_tag
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "web_security_group_id" {
  description = "ID du groupe de sécurité pour le serveur web NGINX."
  value       = aws_security_group.web_sg.id
}