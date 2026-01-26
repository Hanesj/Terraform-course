import {
  to = aws_lambda_function.imported_lambda
  id = "min-test-lambda"
}

data "archive_file" "lambda_code" {
  type        = "zip"
  source_file = "${path.root}/build/index.py"
  output_path = "${path.root}/lambda.zip"

}

resource "aws_lambda_function" "imported_lambda" {
  description      = "First lambda"
  filename         = "lambda.zip"
  function_name    = "min-test-lambda"
  handler          = "index.lambdaFn"
  role             = "arn:aws:iam::000000000000:role/lambda-role"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  tags             = {}
  logging_config {
    log_format = "Text"
    log_group  = "/aws/lambda/min-test-lambda"
  }
}