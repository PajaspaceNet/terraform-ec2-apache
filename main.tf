provider "aws" {
  region = "eu-central-1" # Region Frankfurt
}

# Vytvoření EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-07eef52105e8a2059" # Ubuntu Server 20.04 LTS pro Frankfurt
  instance_type = "t2.micro" # Malá instance vhodná pro Free Tier

  # Skript pro instalaci Apache na Ubuntu
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt upgrade -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "Ahoj z Apache on Ubuntu nainstalovaneho Terraformem! Love you all :-) Pavel " > /var/www/html/index.html
              EOF

  tags = {
    Name = "Terraform-Ubuntu-Apache"
  }
}

# Security group pro EC2
resource "aws_security_group" "web_sg" {
  name_prefix = "terraform-ubuntu-sg-"

  # Povolení příchozího provozu na porty 22 (SSH) a 80 (HTTP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH přístup z libovolné IP
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP přístup z libovolné IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Povolený veškerý odchozí provoz
  }
}

# Připojení security group k EC2 instanci
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.web_sg.id
  network_interface_id = aws_instance.web.primary_network_interface_id
}

# Výstup veřejné IP adresy instance
output "instance_public_ip" {
  value       = aws_instance.web.public_ip
  description = "Veřejná IP adresa Apache serveru"
}
