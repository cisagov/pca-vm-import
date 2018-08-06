# IAM assume role policy document for the role we're creating
data "aws_iam_policy_document" "assume_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["vmie.amazonaws.com"]
    }
  }
}

# The role we're creating
resource "aws_iam_role" "role" {
  name = "${var.role_name}",
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_doc.json}"
}

# IAM policy document that that allows some S3 permissions on our VM
# import bucket.  This will be applied to the role we are creating.
data "aws_iam_policy_document" "s3_doc" {
  statement {
    effect = "Allow"
    
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

# The S3 policy for our role
resource "aws_iam_role_policy" "s3_policy" {
  role = "${aws_iam_role.role.id}"
  policy = "${data.aws_iam_policy_document.s3_doc.json}"
}

# IAM policy document that that allows some EC2 permissions.  This
# will be applied to the role we are creating.
data "aws_iam_policy_document" "ec2_doc" {
  statement {
    effect = "Allow"
    
    actions = [
      "ec2:ModifySnapshotAttribute",
      "ec2:CopySnapshot",
      "ec2:RegisterImage",
      "ec2:Describe*"
    ]

    resources = [
      "*"
    ]
  }
}

# The EC2 policy for our role
resource "aws_iam_role_policy" "ec2_policy" {
  role = "${aws_iam_role.role.id}"
  policy = "${data.aws_iam_policy_document.ec2_doc.json}"
}
