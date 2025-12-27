terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
    # THIS IS THE KEY FIX
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1" # We are pinning a specific recent version
    }
  }
}