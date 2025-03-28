resource "aws_dynamodb_table" "view-count-table" {
  name           = "resume-website-count"
  billing_mode   = "PROVISIONED"
  read_capacity  = 25
  write_capacity = 25
  hash_key       = "website"

  attribute {
    name = "website"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "resume_website" {
  table_name = aws_dynamodb_table.view-count-table.name
  hash_key   = aws_dynamodb_table.view-count-table.hash_key

  item = jsonencode({
    website   = { S = "resume_website" }
    viewCount = { N = "0" }
  })

  lifecycle {
    ignore_changes = [item]
  }
}
