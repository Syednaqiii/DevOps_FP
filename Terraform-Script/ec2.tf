resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_a.id
  key_name      = "devOps-KP"

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id,
  ]
  associate_public_ip_address = true
  tags = {
    Name = "web-server"
  }
     provisioner "local-exec" {
    command = <<EOT
      cd ..
      ls
      echo "[ec2_instances]" > inventory.ini
      echo "${aws_instance.web.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=./devOps-KP.pem" >>  inventory.ini
      ansible-playbook -i inventory.ini playbook.yaml
    EOT
  }
}
