# variables.tf

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type = string
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_ingress_port" {
  description = "Ingress port for EC2 security group"
  type        = number
}

variable "vpc_ingress_cidr_block" {
  description = "CIDR block for VPC security group"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "rds_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "rds_allocated_storage" {
  description = "RDS allocated storage"
  type        = number
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "rds_engine" {
  description = "RDS engine"
  type        = string
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
}

variable "rds_publicly_accessible" {
  description = "RDS publicly accessible"
  type        = bool
}

variable "rds_ingress_port" {
  description = "Ingress port for RDS security group"
  type        = number
}
