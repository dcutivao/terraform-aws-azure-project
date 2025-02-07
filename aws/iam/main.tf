resource "aws_iam_role" "roles" {
  for_each = var.iam_roles

  name = each.key

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = each.value.effect
      Principal = {
        Service = each.value["service"]
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "policies" {
  for_each = var.iam_roles

  name   = "${each.key}-policy"
  policy = jsonencode( {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": each.value.effect,
        "Action": [for action in var.iam_roles: action],
        "Resource": [for resource in var.iam_roles: resource]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "attachments" {
  for_each = var.iam_roles

  policy_arn = aws_iam_policy.policies[each.key].arn
  role       = aws_iam_role.roles[each.key].name
}

resource "aws_iam_instance_profile" "instance_profiles" {
  for_each = { for k, v in var.iam_roles : k => v if v["create_instance_profile"] }

  name = "${each.key}-instance-profile"
  role = aws_iam_role.roles[each.key].name
}