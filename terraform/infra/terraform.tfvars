# terraform.tfvars

aws_region = "ca-central-1"
ec2_instance_type = "t2.micro"
ec2_ingress_port = 8080
vpc_ingress_cidr_block = "0.0.0.0/0"
s3_bucket_name = "my-app-assignment-bucket-213454321"
rds_identifier = "my-app-rds-instance-identifier-123321"
rds_allocated_storage = 20
rds_instance_class = "db.t2.micro"
rds_engine = "mysql"
rds_username = "admin"
rds_publicly_accessible = false
rds_ingress_port = 3306
