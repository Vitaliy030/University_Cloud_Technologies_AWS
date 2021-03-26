region                     = "eu-central-1"
namespace                  = "appname"
stage                      = "dev"
delimiter                  = "-"
label_order                = ["stage", "namespace", "name"]
subscriber_email_addresses = [
    "subscriber_email_addresses4@gmail.com",
    "subscriber_email_addresses5@gmail.com",
    "subscriber_email_addresses6@gmail.com"
]
slack_webhook_url          = "https://hooks.slack.com/services/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"

marketplace_cloudfront_min_ttl = 0
marketplace_cloudfront_default_ttl = 0
marketplace_cloudfront_max_ttl = 0