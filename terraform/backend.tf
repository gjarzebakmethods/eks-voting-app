terraform {
  backend "s3" {
    bucket = "eks-voting-tf-state-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}