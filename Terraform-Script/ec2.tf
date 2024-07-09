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
  key_name      = "DevOps-FP"

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id,
  ]

  tags = {
    Name = "web-server"
  }
  provisioner "local-exec" {
    command = <<EOT
      echo "[ec2_instances]" > $GITHUB_WORKSPACE/Inventory-Ansible/inventory.ini
      echo "$(aws ec2 describe-instances --instance-ids ${self.id} --query 'Reservations[0].Instances[0].PublicIpAddress' --output text) ansible_user=ubuntu ansible_ssh_private_key_file=DevOps-FP" >> $GITHUB_WORKSPACE/Inventory-Ansible/inventory.ini
      ansible-playbook -i $GITHUB_WORKSPACE/Inventory-Ansible/inventory.ini $GITHUB_WORKSPACE/Ansible-Playbook/playbook.yaml
    EOT
  }
}
