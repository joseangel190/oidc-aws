data "aws_iam_policy_document" "github" {
    statement {
        effect = "Allow"
        actions = ["sts:AssumeRoleWithWebIdentity"]

        principals {
            type = "Federated"
            identifiers = [aws_iam_openid_connect_provider.github.arn]
        }

        condition {
            test = "StringEquals"
            variable = "token.actions.githubusercontent.com:aud"
            values = ["sts.amazonaws.com"]
        }

        condition {
             test = "StringLike"
             variable = "token.actions.githubusercontent.com:sub"
             values = ["repo:joseangel190/test:*"]
        }
    }
}

resource "aws_iam_role" "github" {
    name = "github-oidc"
    assume_role_policy = data.aws_iam_policy_document.github.json
}
