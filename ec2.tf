# key pair(login)
resource "aws_key_pair" "my_key" {
  key_name = "terraform-for-devops"
  public_key = file("terraform-for-devops.pub")
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
    instance_type = var.ec2_instance_type
    ami = var.ec2_ami_id
    user_data = file("install-nginx.sh")
    root_block_device {
      volume_size = var.ec2_root_volume_size
      volume_type = "gp3"
    }

    tags = {
        Name = "rutvik-automate-terraform"
    }
}