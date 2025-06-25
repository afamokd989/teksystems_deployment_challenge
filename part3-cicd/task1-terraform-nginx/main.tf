resource "aws_instance" "tek_systems_deployment_challenge" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id     = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "teksystems-deployment-challenge"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
  
}