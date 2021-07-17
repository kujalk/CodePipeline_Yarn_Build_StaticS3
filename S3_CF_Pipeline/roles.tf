//Role for CodeBuild
resource "aws_iam_role" "CodeBuild_Role" {
  name = "${var.Project_Name}-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "CodeBuild_Policy" {
  role   = aws_iam_role.CodeBuild_Role.name
  name   = "${var.Project_Name}-codebuild-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogStream"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudfront:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:*",
        "codecommit:*",
        "codedeploy:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
      "arn:aws:s3:::${var.S3_pipeline_artifactory}",
      "arn:aws:s3:::${var.S3_pipeline_artifactory}/*",
      "arn:aws:s3:::codepipeline*"
      ]
    }
  ]
}
EOF
}

//code pipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.Project_Name}-codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.Project_Name}-codepipeline-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:*",
        "codecommit:*",
        "codedeploy:*",
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}