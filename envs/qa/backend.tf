terraform {
  backend "s3" {
    bucket = "sreeni-terraform-state"
    key = "eks/qa/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
    
  }
}