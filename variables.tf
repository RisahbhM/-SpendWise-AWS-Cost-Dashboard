variable "bucket_name" {
  description = "The unique name of the S3 bucket"
  type        = string
}

variable "cost_alert_email" {
  description = "The email address for SNS notifications"
  type        = string
}
