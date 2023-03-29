resource "aws_s3_bucket" "example" {
  bucket        = local.s3bucket
  policy        = data.aws_iam_policy_document.iampolicyforbucketjson.json
  force_destroy = true
}

resource "aws_s3_bucket" "reportsbucket" {
  bucket        = local.reportsbucket
  policy        = data.aws_iam_policy_document.anotheriampolicyforbucketjson.json
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "disablepublicaccessforreportsbucket" {
  bucket = aws_s3_bucket.reportsbucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#force_destroy
# https://stackoverflow.com/questions/65984400/how-to-delete-non-empty-s3-bucket-with-terraform

# resource "aws_s3_bucket_public_access_block" "example" {
#   bucket = aws_s3_bucket.example.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }
