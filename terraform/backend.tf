terraform {
  required_version = "~> 1.15.0"

  backend "s3" {
    bucket         = "necrux-home-lab-state"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    
    encrypt        = true
  }
}