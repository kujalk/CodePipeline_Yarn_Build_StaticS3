resource "aws_iam_access_key" "key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user" "user" {
  name          = var.iam_user
  path          = "/"
  force_destroy = true
}
