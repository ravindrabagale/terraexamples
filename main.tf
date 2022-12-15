terraform {
  cloud {
    organization = "fortunecloud"
    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      tags = ["terraex", "source:cli"]
    }
  }
}




provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "example" {
  ami                    = "ami-074dc0a6f6c764218"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  user_data = <<EOF
              #!/bin/bash
              yum install -y httpd
              service httpd start
              cd /var/www/html
              echo "Hello, World" > index.html
              EOF
  user_data_replace_on_change = true

  tags = {
    Name = "terraform-new"
  }
}

 

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
 ingress {
    from_port   = 80
    to_port     = 80
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
