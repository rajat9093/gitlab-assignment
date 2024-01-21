# Setting up variables
variable "region" {
  description = "The AWS region to use"
  type        = string
}

variable "aws_access_key" {
  description = "AWS access key" 
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "s3_tf_state_bucket_name" {
  description = "S3 bucket name for tf state"
  type        = string
}

variable "dynamodb_tf_state_table_name" {
  description = "DynamoDb table name for tf state"
  type        = string
}
