variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"  # Oregon region often has lower costs
}

variable "environment" {
  description = "Environment name for tagging"
  type        = string
  default     = "dev"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "voting-app-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Use only 2 AZs instead of 3 to minimize costs
variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]  # Reduced to 2 AZs
}

# Smaller subnet ranges for minimal usage
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/26", "10.0.2.0/26"]  # /26 gives 64 IPs per subnet
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/26", "10.0.102.0/26"]  # /26 gives 64 IPs per subnet
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "voting-app-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.27"
}

# New variables for cost optimization
variable "node_instance_type" {
  description = "EC2 instance type for EKS nodes"
  type        = string
  default     = "t3.small"  # Cheapest instance type that meets EKS requirements
}

variable "node_desired_size" {
  description = "Desired number of nodes in the node group"
  type        = number
  default     = 1  # Minimal number of nodes
}

variable "node_min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
  default     = 1  # Minimal number of nodes
}

variable "node_max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
  default     = 2  # Small maximum to allow for minimal scaling
}

variable "enable_spot_instances" {
  description = "Whether to use spot instances for cost savings"
  type        = bool
  default     = true  # Enable spot instances for cost savings
}

variable "spot_allocation_strategy" {
  description = "Spot instance allocation strategy"
  type        = string
  default     = "capacity-optimized"  # Best for availability
} 