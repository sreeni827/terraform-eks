module "eks_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "20.36.0"  # optional but recommended

  cluster_name    = var.cluster_name
  cluster_version = var.k8s_version
  subnet_ids      = var.subnet_ids

  name            = var.node_group_name
  instance_types  = ["t3.medium"]

  desired_size = 2
  max_size     = 3
  min_size     = 1

  cluster_service_cidr = "172.20.0.0/16"  
  
  

  tags = var.tags
}
