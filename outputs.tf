output "bucket_name" {
  description = "SpendWise Dashboard S3 Bucket"
  value       = aws_s3_bucket.dashboard.id
}

output "lambda_function_name" {
  description = "SpendWise Cost Alert Lambda Function"
  value       = aws_lambda_function.cost_alert_lambda.function_name
}

output "sns_topic_arn" {
  description = "SNS Topic for Cost Alerts"
  value       = aws_sns_topic.alerts.arn
}
