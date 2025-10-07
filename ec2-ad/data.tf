# Data sources for base infrastructure
data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key    = "infrastructure-ad/terraform.tfstate"
    region = var.aws_region
  }
}
