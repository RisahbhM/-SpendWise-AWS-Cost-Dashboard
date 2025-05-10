# -------------------
# SpendWise Resources
# -------------------

resource "aws_s3_bucket" "dashboard" {
  bucket = var.bucket_name

  tags = {
    Name = "SpendWise Dashboard"
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.dashboard.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.dashboard.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.dashboard.arn}/*"
      }
    ]
  })
}

resource "aws_dynamodb_table" "spendwise_costs" {
  name           = "SpendWiseCosts"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "account_id"

  attribute {
    name = "account_id"
    type = "S"
  }

  tags = {
    Name = "SpendWise Costs Table"
  }
}

resource "aws_sns_topic" "alerts" {
  name = "cost-alerts-topic"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "spendwise_lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_publish_policy" {
  name = "spendwise_lambda_publish_policy"
  role = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem"
        ]
        Resource = aws_dynamodb_table.spendwise_costs.arn
      }
    ]
  })
}

resource "aws_lambda_function" "cost_alert_lambda" {
  filename         = "${path.module}/lambda/cost_alert.zip"
  function_name    = "CostAlertLambda"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "cost_alert.lambda_handler"
  runtime          = "python3.10"
  source_code_hash = filebase64sha256("${path.module}/lambda/cost_alert.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.spendwise_costs.name
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "billing_alarm" {
  alarm_name          = "SpendWise-Billing-Alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600"
  statistic           = "Maximum"
  threshold           = "10"
  alarm_description   = "Alarm if AWS bill exceeds $10"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  dimensions = {
    Currency = "USD"
  }
}
