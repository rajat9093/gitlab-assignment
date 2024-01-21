# Configure the AWS provider
provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_access_key
}
