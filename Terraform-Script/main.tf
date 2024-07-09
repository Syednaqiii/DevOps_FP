terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = ${{ secrets.AWS_ACCESS_KEY_ID }}
  secret_key = ${{ secrets.AWS_SECRET_ACCESS_KEY }}
}

resource "tls_private_key" "rsa_4096"{
    algorithm = "RSA"
    rsa_bits = 4096
}


resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
     content = tls_private_key.rsa_4096.private_key_pem
     filename = var.key_name
  
}
terraform {
  backend "s3" {
    bucket = "tf-ec2-s3-backend"                 # my bucket name i.e created manually
    key    = "environment/dev/terraform.tfstate" # The path within the bucket to store the state file
    region = "us-east-1"
    #encrypt        = true                             
    #dynamodb_table = "terraform-lock-table"           
  }
}
