module "vpc" {
  source         = "../../modules/vpc"
  name           = "qa_vpc"
  vpc_cidr       = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  tags = {
    Environment = "qa"
    Project     = "EKS"
  }
}

module "iam" {
  source = "../../modules/iam"
  env    = "EKS"
}

module "eks" {
  source       = "../../modules/eks"
  cluster_name = "eks-dev"
  k8s_version  = "1.27"
  subnet_ids   = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id

  tags = {
    Environment = "dev"
    Project     = "EKS"
  }

  # ✅ This block prevents the pipeline from failing at CoreDNS creation
  cluster_addons = {
    coredns = {
      most_recent        = true
      resolve_conflicts  = "OVERWRITE"
      create             = false    # ⛔ Skip CoreDNS add-on for now
    }
    kube-proxy = {
      most_recent        = true
      resolve_conflicts  = "OVERWRITE"
      create             = true
    }
    vpc-cni = {
      most_recent        = true
      resolve_conflicts  = "OVERWRITE"
      create             = true
    }
  }
}

module "node_group" {
  source           = "../../modules/node_group"
  cluster_name     = "eks-dev"
  k8s_version      = "1.27"
  subnet_ids       = module.vpc.private_subnets
  node_group_name  = "dev-ng"

  tags = {
    Environment = "dev"
    Project     = "EKS"
  }

  depends_on = [module.eks]
}
