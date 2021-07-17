variable "price_class" {
  type        = string
  description = "Cloud Front Price Class"
}

variable "bucket_name" {
  type        = string
  description = "Cloud Front Price Class"
}

variable "origin-id" {
  type        = string
  description = "Unique Origin ID"
}

variable "iam_user" {
  type        = string
  description = "IAM User Name"
}

variable "origin-id-comment" {
  type        = string
  description = "Origin ID comment"
}

variable "distribution-comment" {
  type        = string
  description = "Cloud Front distribution comment"
}

variable "root-object" {
  type        = string
  description = "Root object for S3"
}

variable "Project_Name" {
  type    = string
  default = ""
}

variable "Github_token" {
  type    = string
  default = ""
}

variable "Github_owner" {
  type    = string
  default = ""
}

variable "Github_repo" {
  type    = string
  default = ""
}

variable "Github_branch" {
  type    = string
  default = ""
}

variable "Pipeline_name" {
  type    = string
  default = ""
}

variable "Github_repo_url" {
  type    = string
  default = ""
}

variable "S3_pipeline_artifactory" {
  type    = string
  default = ""
}