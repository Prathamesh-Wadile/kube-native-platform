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

# ... (Keep all your existing VPC/EKS code above) ...

# 1. NEW: Get the Authentication Token natively
# This avoids using the CLI and external scripts
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

# 2. Configure Helm using the native token
provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
