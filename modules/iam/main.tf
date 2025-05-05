resource "aws_iam_role" "eks_cluster_role" {
    name = "${var.env}-eks-cluster-role"
    assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json

  
}

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
    role = aws_iam_role.eks_cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  
}

output "eks_cluster_role_arn" {
    value = aws_iam_role.eks_cluster_role.arn
  
}