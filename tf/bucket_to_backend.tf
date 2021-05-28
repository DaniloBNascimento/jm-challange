terraform {
  backend "s3" {
    bucket = "infra-jm"
    key    = "tf-state/"
    region = "us-east-2"
  }
}