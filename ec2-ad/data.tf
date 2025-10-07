# Data sources for base infrastructure
data "terraform_remote_state" "base" {
  backend = "local"
  config = {
    path = "../infrastructure-ad/terraform.tfstate"
  }
}
