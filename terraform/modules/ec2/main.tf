variable "security_group" {
  description = "The security groups assigned to the Jenkins server"
}

variable "public_subnet" {
  description = "The public subnet IDs assigned to the Jenkins server"
}

variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type        = string
  default     = "jenkins_kp"
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]

}

resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.ubuntu.id
  subnet_id              = var.public_subnet
  instance_type          = "t2.small"
  vpc_security_group_ids = [var.security_group]
  key_name               = var.instance_keypair
  user_data              = file("modules/ec2/install_jenkins.sh")

  tags = {
    Name = "jenkins_server"
  }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_server.id
  vpc      = true

  tags = {
    Name = "jenkins_eip"
  }
}
