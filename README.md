# terraform-aws-ses

Terraform module for deploying and managing AWS SES.

## Usage
#
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "main" {
  comment = "External hosted zone for Flixxo Dev"
  name    = "example.com"
}


module "ses" {
  source = "../tf-aws-ses"
  domain  = "example.com"
  zone_id = "${aws_route53_zone.main.zone_id}"
}

output "smtp_id" {
  value = "${module.ses.smtp_id}"
}

output "smtp_secret" {
  value = "${module.ses.smtp_secret}"
}
```

## Variables

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| domain | Domain to use for SES | - | yes |
| zone_id | Route 53 zone ID for the SES domain verification | - | yes |
| dkim_record_count | The number of DKIM records to add to Route53 | - | no |
| dkim_ttl | TTL for DKIM records. Default is 300 seconds | - | no |
| ses_ttl | TTL for SES Verification record. Default is 300 seconds | - | no |
| mail_ttl | TTL for Mail Verification record. Default is 600 seconds | - | no |
| mailer | The SMTP user name | - | no |
| mail_from | The user name for the mail from | - | no |
| mail_from_mx_record | The DNS record for MX | - | no |
| mail_from_txt_record | The TXT DNS record for the mail from | - | no |

## Outputs

| Name | Description |
|------|-------------|
| domain_identity_arn | ARN of the SES domain identity |
| ses_verification_token | SES Verification Token |
| smtp_id | SMTP username |
| smtp_secret | SMTP password |
