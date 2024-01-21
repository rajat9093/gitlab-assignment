# Provider configuration
provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
}

# Backend configuration
terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket-123098345"
    key            = "terraform/state.tfstate"
    region         =  "ca-central-1"
    encrypt        = true
   # dynamodb_table = "my-tf-state-dynamodb-table"
  }
}
