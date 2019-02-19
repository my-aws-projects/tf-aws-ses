variable "domain" {
  description = "Domain to use for SES"
}

variable "zone_id" {
  description = "Route 53 zone ID for the SES domain verification"
}

variable "dkim_ttl" {
  description = "TTL for DKIM records. Default is 300 seconds"
  default     = "300"
}

variable "ses_ttl" {
  description = "TTL for SES Verification record. Default is 300 seconds"
  default     = "300"
}

variable "mail_ttl" {
  description = "TTL for Mail Verification record. Default is 600 seconds"
  default     = "600"
}

variable "dkim_record_count" {
  description = "Count for the DKIM record entry in DNS"
  default     = "3"
}

variable "mailer" {
  description = "The user name"
  default     = "mailer"
}

variable "mail_from" {
  description = "User name for the mail from"
  default     = "bounce"
}

variable "mail_from_mx_record" {
  description = "DNS record for the mail from"
  default     = "10 inbound-smtp.us.east-1.amazonaws.com"
}

variable "mail_from_txt_record" {
  description = "DNS record for the mail from txt"
  default     = "v=spf1 include:amazonses.com -all"
}
