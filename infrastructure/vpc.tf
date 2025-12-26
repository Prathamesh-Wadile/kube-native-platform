module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # STABLE Version

  name = "${local.name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = local.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # SIMPLIFIED NETWORKING
  # We use a NAT Gateway for standard compliance, 
  # but we will put nodes in Public Subnets for reliability.
  enable_nat_gateway = true
  single_nat_gateway = true

  # CRITICAL: Ensures nodes get an IP to talk to the internet
  map_public_ip_on_launch = true

  # Tags needed for Load Balancers to find the subnets later
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  tags = local.tags
}