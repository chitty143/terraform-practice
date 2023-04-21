


resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.user_one.name,
    aws_iam_user.user_two.name,
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group" "group" {
  name = "test"
}

resource "aws_iam_user" "user_one" {
  name = "alias"
}

resource "aws_iam_user" "user_two" {
  name = "alias1"
}



data "aws_iam_policy_document" "lb_ro" {
  statement {
    effect    = "Allow"
    actions   = ["s3:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "lb_ro" {
  name   = "dude"
  user   = aws_iam_user.user_one.name
  policy = data.aws_iam_policy_document.lb_ro.json
}