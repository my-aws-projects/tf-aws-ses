resource "aws_ses_domain_identity" "ses_domain" {
  domain   = "${var.domain}"
}

resource "aws_ses_domain_dkim" "ses_dkim_records" {
  domain   = "${aws_ses_domain_identity.ses_domain.domain}"
}

resource "aws_ses_domain_mail_from" "ses_domain_mail" {
  domain           = "${aws_ses_domain_identity.ses_domain.domain}"
  mail_from_domain = "${var.mail_from}.${aws_ses_domain_identity.ses_domain.domain}"
}

resource "aws_route53_record" "ses_domain_mail_from_mx" {
  zone_id = "${var.zone_id}"
  name    = "${aws_ses_domain_mail_from.ses_domain_mail.mail_from_domain}"
  type    = "MX"
  ttl     = "${var.mail_ttl}"
  records = ["${var.mail_from_mx_record}"]
}

resource "aws_route53_record" "ses_domain_mail_from_txt" {
  zone_id = "${var.zone_id}"
  name    = "${aws_ses_domain_mail_from.ses_domain_mail.mail_from_domain}"
  type    = "TXT"
  ttl     = "${var.mail_ttl}"
  records = ["${var.mail_from_txt_record}"]
}

resource "aws_route53_record" "domain_dkim_record" {
  count   = "${var.dkim_record_count}"
  zone_id = "${var.zone_id}"
  name    = "${element(aws_ses_domain_dkim.ses_dkim_records.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "${var.dkim_ttl}"
  records = ["${element(aws_ses_domain_dkim.ses_dkim_records.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "domain_amazonses_verification_record" {
  zone_id = "${var.zone_id}"
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "${var.ses_ttl}"
  records = ["${aws_ses_domain_identity.ses_domain.verification_token}"]
}
