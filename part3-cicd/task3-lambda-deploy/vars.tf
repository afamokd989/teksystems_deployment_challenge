variable "policy_arn" {
  description = "The ARN of the IAM policy to attach to the Lambda execution role."
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string

}

variable "lambda_handler" {
  description = "The handler for the Lambda function."
  type        = string

}
variable "lambda_runtime" {
  description = "The runtime environment for the Lambda function."
  type        = string

}

variable "lambda_exec_role_name" {
  description = "The name of the IAM role for Lambda execution."
  type        = string

}