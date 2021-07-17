//code build
resource "aws_codebuild_project" "code-build" {
  name         = "${var.Project_Name}-code-build"
  description  = "${var.Project_Name}- code build phase"
  service_role = aws_iam_role.CodeBuild_Role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "S3_BUCKET"
      value = "s3://${var.bucket_name}"
    }

    environment_variable {
      name  = "DistributionID"
      value = aws_cloudfront_distribution.s3_distribution.id
    }

  }
  source {
    type            = "GITHUB"
    location        = var.Github_repo_url
    git_clone_depth = 1
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.log_group.name
      stream_name = aws_cloudwatch_log_stream.stream.name
    }

  }
}

//pipeline
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket        = var.S3_pipeline_artifactory
  acl           = "private"
  force_destroy = true
}

resource "aws_codepipeline" "codepipeline" {
  name     = var.Pipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        OAuthToken           = var.Github_token
        Owner                = var.Github_owner
        Repo                 = var.Github_repo
        Branch               = var.Github_branch
        PollForSourceChanges = "true"
      }
    }

  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.code-build.name
      }
    }
  }

}
