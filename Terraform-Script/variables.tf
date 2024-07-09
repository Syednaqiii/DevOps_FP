variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for public subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "The CIDR block for public subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  description = "The CIDR block for private subnet A"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  description = "The CIDR block for private subnet B"
  type        = string
  default     = "10.0.4.0/24"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "allowed_ssh_cidr" {
  description = "The CIDR block allowed to SSH into the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use"
  type        = string
  default     = ""
}
variable "aws_access_key" {
  description = "The AWS access key"
  type        = string
  default     = "" # Leave empty, will be set via environment variables
}

variable "aws_secret_key" {
  description = "The AWS secret key"
  type        = string
  default     = "" # Leave empty, will be set via environment variables
}
