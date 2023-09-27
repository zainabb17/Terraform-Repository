resource "aws_iam_user" "iam_users" {
  for_each = var.users

  name = each.key
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each = var.users
  user       = aws_iam_user.iam_users[each.key].name
  policy_arn = each.value
}

output "user_names" {
  value = [for user_name in keys(aws_iam_user.iam_users) : user_name]
}