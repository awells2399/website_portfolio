resource "aws_dynamodb_table" "view-count-table" {
  name           = "view-count-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 25
  write_capacity = 25
  hash_key       = "views"

  attribute {
    name = "views"
    type = "N"
  }

  #   replica {
  #     region_name = "us-east-2"
  #   }

  #   replica {
  #     region_name = "us-west-2"
  #   }

}
