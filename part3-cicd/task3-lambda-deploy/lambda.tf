resource "aws_iam_role" "lambda_exec" {
  name        = var.lambda_exec_role_name
  description = "IAM role for Lambda execution with basic permissions"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "afam-bootstrap-lambda-execution-role"
    Environment = "production"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = var.policy_arn
}

resource "aws_lambda_function" "afam-financial-lambda" {
  function_name = var.lambda_function_name
  description   = "Bootstrap Lambda function for Afam Financial"
  role          = aws_iam_role.lambda_exec.arn
  handler       = var.lambda_handler
  runtime       = "python3.11"

  filename         = "${path.module}/bootstrap_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/bootstrap_lambda.zip")

  environment {
    variables = {
      ENV_STAGE = "prod"
    }
  }

  tags = {
    Name        = "afam-financial-lambda"
    Environment = "production"
  }
}

output "bootstrap_lambda_function_name" {
  value = aws_lambda_function.afam-financial-lambda.function_name
}

output "bootstrap_lambda_function_arn" {
  value = aws_lambda_function.afam-financial-lambda.arn
}
