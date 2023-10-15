resource "aws_instance" "ec2_win" {
  ami                    = data.aws_ami.latest-windows.id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.sg-web-server.id]
  get_password_data      = true
  user_data              = <<EOF

    <powershell>
      Install-WindowsFeature -name Web-Server -IncludeManagementTools
    </powershell>

  EOF

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "sg-web-server" {
  name        = "SG Web and RDP"
  description = "Allows RDP 3389 to specific IP, HTTP 80 & HTTPS 443 to all"

  tags = {
    Name = "SG Web and RDP"
  }

  ingress {
    from_port   = 3389
    protocol    = "tcp"
    to_port     = 3389
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
