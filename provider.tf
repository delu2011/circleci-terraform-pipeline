## Configure the AWS Provider
provider "aws" {
  region  = "${var.AWS_REGION}"
  version = "1.54"
}

provider "template" {
  version = "1.0"
}

terraform {
  required_version = "> 0.11.7"

  backend "s3" {
    bucket  = "stage-terraform-backend-terraformstatebucket-1w6taasp55yun"
    key     = "terraform-state"
    region  = "us-east-2"
    encrypt = "true"
  }
}
