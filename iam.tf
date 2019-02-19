resource "aws_iam_user" "mailer" {
  name = "${var.mailer}" 
}

resource "aws_iam_access_key" "mailer" {
  user = "${aws_iam_user.mailer.name}"
}

resource "aws_iam_user_policy" "mailer" {
  name = "${var.mailer}" 
  user = "${aws_iam_user.mailer.name}"
  policy = "${data.aws_iam_policy_document.allow_mailer_to_send_emails.json}"
}

data "aws_iam_policy_document" "allow_mailer_to_send_emails" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}
