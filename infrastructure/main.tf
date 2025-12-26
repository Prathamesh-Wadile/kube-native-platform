provider "aws" {
  region = "eu-west-1"
}

# Automatically find available zones in Ireland
data "aws_availability_zones" "available" {
  state = "available"
}

# Define project-wide variables
locals {
  name   = "kube-native"
  region = "eu-west-1"
  
  # dynamic calculation of zones
  azs = slice(data.aws_availability_zones.available.names, 0, 2)

  tags = {
    Project   = "kube-native-platform"
    ManagedBy = "Terraform"
  }
}