
# reads data from the vpc remote state file. to use it dbcluster 
data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "my-bucket-tfstate-sus"
        key    = "vpc/${var.ENV}/terraform.tfvars"
        region = "us-east-1"
    }
  
}

