output "webstie-url" {
  value = "Resume website: ${aws_s3_bucket.static_website.website_endpoint}"

}

output "dynamodb-table-name" {
  value = aws_dynamodb_table.view-count-table.name
}

output "dynamodb-table-arn" {
  value = aws_dynamodb_table.view-count-table.arn

}
