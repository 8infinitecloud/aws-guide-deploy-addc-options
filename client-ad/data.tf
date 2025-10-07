# Data sources for base infrastructure
data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key    = "infrastructure-ad/terraform.tfstate"
    region = var.aws_region
  }
}

# Data source for AD (choose one based on your AD type)
data "terraform_remote_state" "ad" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key    = var.ad_type == "managed-ad" ? "managed-ad/terraform.tfstate" : 
             var.ad_type == "simple-ad" ? "simple-ad/terraform.tfstate" :
             var.ad_type == "ec2-ad" ? "ec2-ad/terraform.tfstate" :
             "connector-ad/terraform.tfstate"
    region = var.aws_region
  }
}
