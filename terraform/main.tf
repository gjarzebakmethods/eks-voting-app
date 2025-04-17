terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

# VPC Module - Minimal configuration for POC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  # Use only 2 AZs instead of 3
  azs             = slice(var.availability_zones, 0, 2)
  private_subnets = slice(var.private_subnet_cidrs, 0, 2)
  public_subnets  = slice(var.public_subnet_cidrs, 0, 2)

  # Minimal NAT gateway configuration
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# EKS Cluster Module - Minimal configuration for POC
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # Minimal node group configuration
  eks_managed_node_groups = {
    default = {
      min_size     = var.node_min_size
      max_size     = var.node_max_size
      desired_size = var.node_desired_size

      # Use t3.small instead of t3.medium for lower costs
      instance_types = [var.node_instance_type]
      capacity_type  = var.enable_spot_instances ? "SPOT" : "ON_DEMAND"

      # Spot instance configuration
      spot_allocation_strategy = var.spot_allocation_strategy

      # Minimal node configuration
      labels = {
        Environment = var.environment
        NodeGroup   = "default"
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
} 