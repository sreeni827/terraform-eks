module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.1.0"

    name = var.name
    cidr = var.vpc_cidr

    azs = var.azs
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets

    enable_nat_gateway = true
    single_nat_gateway = true

    tags = var.tags
}