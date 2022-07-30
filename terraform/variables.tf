variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "my_ip" {
  description = "open public since I don't have a static ip but this is not good practice"
  type        = string
  sensitive   = true
  default     = "0.0.0.0"
}
