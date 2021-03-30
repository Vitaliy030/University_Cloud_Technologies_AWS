variable "subscriber_email_addresses" {
  type    = list(string)
  default = [
    "subscriber_email_addresses1@gmail.com",
    "subscriber_email_addresses2@gmail.com",
    "subscriber_email_addresses3@gmail.com"
  ]
}

variable "slack_webhook_url" {
  type = string
  default = "https://hooks.slack.com/services/AAA/BBB/CCC"
}