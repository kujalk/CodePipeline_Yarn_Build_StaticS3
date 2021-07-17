Purpose
---------
CI/CD pipeline for yarn based project and to host the website in S3 with Cloudfront distribution

Instructions
-------------
- This template will create,
    S3 with IAM user (programmatic access to S3)
    CloudFront distribution
    Code pipeline, IAM role and S3 bucket for storing artifactory

Pre-Requisites
----------------
- Copy the buildspec.yaml attached with this into the root folder of the repository (don't put in subfolder)
- Make sure you have the created token from GitHub -> Go to Developer Settings and get it
  
Creation of Resources
------------------------
- Fill the provider.tf and terraform.tfvars
- Apply the commands in following orders,
terraform init
terraform plan
terraform apply


Deletion of resources
---------------
- Apply "terraform destroy"


Developer - K.Janarthanan