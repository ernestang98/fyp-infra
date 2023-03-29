locals {
  s3bucket = lower("test-${random_string.suffix.result}")
}

locals {
  reportsbucket = lower("reportsbucket-${random_string.suffix.result}")
}


data "aws_iam_policy_document" "iampolicyforbucketjson" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      "arn:aws:s3:::${local.s3bucket}/*",
      "arn:aws:s3:::${local.s3bucket}"
    ]
  }
}

data "aws_iam_policy_document" "iampolicyforuserjson" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${local.s3bucket}/*",
      "arn:aws:s3:::${local.s3bucket}"
    ]
  }
}

data "aws_iam_policy_document" "anotheriampolicyforbucketjson" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      "arn:aws:s3:::${local.reportsbucket}/*",
      "arn:aws:s3:::${local.reportsbucket}"
    ]
  }
}

data "aws_iam_policy_document" "anotheriampolicyforuserjson" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]
    resources = [
      "arn:aws:s3:::${local.reportsbucket}/*",
      "arn:aws:s3:::${local.reportsbucket}"
    ]
  }
}

resource "aws_iam_policy" "iampolicyforuser" {
  policy = data.aws_iam_policy_document.iampolicyforuserjson.json
}

resource "aws_iam_user_policy_attachment" "attachiampolicytouser" {
  user       = "ernest"
  policy_arn = aws_iam_policy.iampolicyforuser.arn
}

resource "aws_iam_policy" "anotheriampolicyforuser" {
  policy = data.aws_iam_policy_document.anotheriampolicyforuserjson.json
}

resource "aws_iam_user_policy_attachment" "attachanotheriampolicytouser" {
  user       = "ernest"
  policy_arn = aws_iam_policy.anotheriampolicyforuser.arn
}
