# output "webstie-url" {
#   value = "Resume website: ${aws_s3_bucket.static_website.website_endpoint}"

# }

output "dynamodb-table-name" {
  value = aws_dynamodb_table.view-count-table.name
}

output "dynamodb-table-arn" {
  value = aws_dynamodb_table.view-count-table.arn

}

output "Cloudfront-url" {
  value = aws_cloudfront_distribution.static_website_distribution.domain_name
}

output "custom-domain-url" {
  value = aws_cloudfront_distribution.static_website_distribution.aliases
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.static_website.bucket_regional_domain_name

}

output "api_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}/view_count"
}
