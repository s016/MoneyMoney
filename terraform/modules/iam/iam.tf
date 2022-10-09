variable "iam_name" {}
variable "policy" {}
variable "identifiers" {}

#iamロールで使うポリシーのドキュメント
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [var.identifiers]
    }
  }
}

#iamロールの定義
resource "aws_iam_role" "default" {
  name               = var.iam_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

#iamポリシー
resource "aws_iam_policy" "default" {
  name   = var.iam_name
  policy = var.policy
}

#iamロールにiamポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.default.arn
}

output "iam_role_arn" {
  value = aws_iam_role.default.arn
}

output "iam_role_name" {
  value = aws_iam_role.default.name
}
