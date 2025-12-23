# Key pair (login to EC2 instances)

resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}     


# VPC & Security Group

resource "aws_default_vpc" "default" {
 
}

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "This will add in TF generated Security group"
  vpc_id      = aws_default_vpc.default.id # Interpolating the VPC ID

  # Inbound rules
     ingress {
    from_port   = 22
    to_port     = 22            
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH from anywhere"
    }

   ingress  {
    from_port   = 80
    to_port     = 80            
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"

   }

   ingress {
    from_port   = 8000
    to_port     = 8000           
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow TCP 8000 from anywhere"
   }
  # Outbound rules

    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
    tags = {
    Name = "automate-sg"
      }
}


# EC2 Instance

resource "aws_instance" "my_instance" {
  key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = "t2.micro"
    ami = "ami-02b8269d5e85954ef" # Ubuntu Linux 2 AMI (ap-south-1)

    root_block_device {
    volume_size = 15
    volume_type = "gp3"
 }

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}
