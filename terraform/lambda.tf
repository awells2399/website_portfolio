data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.module}/../lambda_functions/get_view_count.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "cloud-resume-website"
  }

}

resource "aws_iam_policy" "dynamodb_update_policy" {
  name        = "dynamodb_update_policy"
  description = "Policy to allow Lambda function to update an item in DynamoDB"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:UpdateItem"
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.view-count-table.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_update_policy.arn
}

resource "aws_lambda_function" "this" {
  description      = "Function to retrieve view count from DynamoDB."
  filename         = "lambda.zip"
  function_name    = "get_view_count"
  handler          = "get_view_count.lambda_handler"
  role             = aws_iam_role.lambda_execution_role.arn
  runtime          = "python3.13"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256

  tags = {
    Project = "cloud-resume-website"
  }


  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/get_view_count"
  }

}
