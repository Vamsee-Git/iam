terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-two-tier-vamsee"
    key            = "terraform/iam"
    region         = "ap-south-1"
  }
}
