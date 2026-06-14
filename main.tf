provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = "revanth-kunala-cloud-project-954976313883"
}

resource "aws_security_group" "web_sg" {
  name = "terraform-web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {
  ami                    = "ami-0e38835daf6b8a2b9"
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Terraform-WebServer"
  }
}
