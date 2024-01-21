# Getting latest Amazon linux2 AMI
data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Getting existing key pair
data "aws_key_pair" "test" {
  key_name           = "test"
  include_public_key = true
}

# Creating EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.latest_amazon_linux_2.id
  instance_type = var.ec2_instance_type
  key_name = data.aws_key_pair.test.key_name

  # Security group
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  # IAM instance profile
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  # Tags
  tags = {
    Name = "app-instance"
    Project = "Assignment"
    Team = "Devops"
  }
}

# Creating S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"
}

# Creating RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier            = var.rds_identifier
  allocated_storage     = var.rds_allocated_storage
  instance_class        = var.rds_instance_class
  engine                = var.rds_engine
  username              = var.rds_username
  password              = var.rds_password
  publicly_accessible   = var.rds_publicly_accessible

  # Security group
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
}

# Security Group for EC2
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Security group for EC2 instance"

  ingress {
    from_port = var.ec2_ingress_port
    to_port   = var.ec2_ingress_port
    protocol  = "tcp"
    cidr_blocks = [var.vpc_ingress_cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_ingress_cidr_block]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_security_group" {
  name        = "rds_security_group"
  description = "Security group for RDS instance"

  ingress {
    from_port   = var.rds_ingress_port
    to_port     = var.rds_ingress_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_ingress_cidr_block]
  }
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM Policy for S3 and RDS
resource "aws_iam_policy" "custom_access_policy" {
  name        = "custom_access_policy"
  description = "Custom access to S3 and RDS"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "rds:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "custom_access_attachment" {
  policy_arn = aws_iam_policy.custom_access_policy.arn
  role       = aws_iam_role.ec2_role.name
}

# Getting instance public_ip as output
output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
