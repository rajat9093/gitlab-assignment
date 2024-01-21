# Creating an S3 bucket for tf state
resource "aws_s3_bucket" "state_bucket" {
  bucket = var.s3_tf_state_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}

# Creating a DynamoDB table for tf state
resource "aws_dynamodb_table" "state_table" {
  name           = var.dynamodb_tf_state_table_name
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "assign_id"
  
  attribute {
    name = "assign_id"
    type = "S"
  }
}
