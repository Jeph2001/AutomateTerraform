 terraform {
   required_providers {
     aws = {
        source = "hashicorp/aws"
        version = "5.10.0"
     }
   }

   backend "s3" {
     bucket = "myterraformprojectwebsite20011231"
     key = "terraform/state.tfstate"
     region = "us-west-2"
   }

 }

 provider "aws" {
   region = "us-west-2"
 }

 provider "github" {
   token = var.github_token
 }