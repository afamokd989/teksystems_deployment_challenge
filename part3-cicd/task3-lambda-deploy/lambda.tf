resource "aws_iam_role" "lambda_exec" {
  name = "afam-bootstrap-lambda-execution-role"

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
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "afam-financial-lambda" {
  function_name = "afam-financial-lambda"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "bootstrap-lambda.lambda_handler"
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
