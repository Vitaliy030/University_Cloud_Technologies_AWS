variable "alarm_emails" {
    type = set(string)
    default = [
        "subscriber_email_addresses1@gmail.com",
        "subscriber_email_addresses2@gmail.com",
        "subscriber_email_addresses3@gmail.com"
    ]
}