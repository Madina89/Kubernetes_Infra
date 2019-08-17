terraform {
 backend "s3" {
 bucket = "madina-kubernetesstate.com"
 key = "terraform"
 region = "us-east-2"
 } 
}
