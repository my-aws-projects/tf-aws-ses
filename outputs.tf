output "domain_identity_arn" {
  description = "ARN of the SES domain identity"
  value       = "${aws_ses_domain_identity.ses_domain.arn}"
}

output "ses_verification_token" {
  value = "${aws_ses_domain_identity.ses_domain.verification_token}"
}

output "smtp_id" {
  value = "${aws_iam_access_key.mailer.id}"
}
 
output "smtp_secret" {
  value = "${aws_iam_access_key.mailer.secret}"
}
