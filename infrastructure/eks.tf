module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # STABLE Version (v21 caused the errors)

  cluster_name    = "${local.name}-cluster"
  cluster_version = "1.30"

  # Networking
  cluster_endpoint_public_access = true
  
  vpc_id = module.vpc.vpc_id
  
  # THE STABILITY FIX: Put nodes in PUBLIC subnets.
  # This bypasses complex private routing issues.
  subnet_ids = module.vpc.public_subnets

  # Permissions
  enable_cluster_creator_admin_permissions = true

  # Node Group Configuration
  eks_managed_node_groups = {
    primary = {
      min_size     = 1
      max_size     = 2
      desired_size = 2

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      
      # Explicitly confirm public IP assignment
      associate_public_ip_address = true
    }
  }

  tags = local.tags
}