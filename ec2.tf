# key pair(login)
resource "aws_key_pair" "my_key" {
  key_name = "terraform-form-devoosdde"
  public_key = file("terraform-for-devoosde.pub")
}

# vpc & security group
resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_security" {
  name = "automate-sg"
  description = "this will add a TF generated security group"
  vpc_id = aws_default_vpc.default.id #interpolation

# inbound rules
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh open"
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http open"
  }

#outbond rules

egress {
    from_port = 0
    to_port = 0
    protocol = "-1"  #symentically equivalent to all ports
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
}


  tags = {
    Name = "automate-sg"
  }
}

# ec2 instance
resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security.name]
    instance_type = "t2.micro"
    ami = "ami-0d1b5a8c13042c939" #ubuntu

    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }

    tags = {
        Name = "rutvik-automate-terraform"
    }
}