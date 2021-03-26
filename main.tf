module "frontend" {
  source      = "./modules/s3/eu-central-1"
  context     = module.base_labels.context
  name        = "frontend"
  label_order = var.label_order
#   marketplace_cloudfront_min_ttl = var.marketplace_cloudfront_min_ttl
#   marketplace_cloudfront_default_ttl = var.marketplace_cloudfront_default_ttl
#   marketplace_cloudfront_max_ttl = var.marketplace_cloudfront_max_ttl
}

module "dynamo_db_courses" {
  source      = "./modules/dynamodb/eu-central-1"
  context     = module.base_labels.context
  name        = "courses"
}

module "dynamo_db_authors" {
  source      = "./modules/dynamodb/eu-central-1"
  context     = module.base_labels.context
  name        = "authors"
}

module "lambda" {
  source          = "./modules/lambda/eu-central-1"
  context         = module.base_labels.context
  name            = "lambda"
  role_get_all_authors_arn = module.iam.role_get_all_authors_arn
  role_get_all_courses_arn = module.iam.role_get_all_courses_arn
  role_get_course_arn = module.iam.role_get_course_arn
  role_save_update_course_arn = module.iam.role_save_update_course_arn
  role_delete_course_arn = module.iam.role_delete_course_arn

  dynamo_db_authors_name = module.dynamo_db_authors.dynamp_db_name
  dynamo_db_courses_name = module.dynamo_db_courses.dynamp_db_name
}

module "iam" {
  source                = "./modules/iam"
  context               = module.base_labels.context
  name                  = "iam"
  dynamo_db_authors_arn = module.dynamo_db_authors.dynamp_db_arn
  dynamo_db_courses_arn = module.dynamo_db_courses.dynamp_db_arn
}

module "notified_Lambda" {
  source      = "./modules/notified_Lambda/eu-central-1"
  context     = module.base_labels.context
  name        = "notified_Lambda"
}




# Перенести в окремий модуль
resource "aws_budgets_budget" "this" {
  name              = module.base_labels.id
  budget_type       = "COST"
  limit_amount      = "1.0"
  limit_unit        = "USD"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.subscriber_email_addresses
    subscriber_sns_topic_arns  = [module.notify_slack.this_slack_topic_arn]
  }
}

module "notify_slack" {
  source  = "terraform-aws-modules/notify-slack/aws"
  version = "~> 4.0"

  sns_topic_name = module.base_labels.id

  slack_webhook_url = var.slack_webhook_url
  slack_channel     = "aws-notification"
  slack_username    = "Vitalii Romanko"
}