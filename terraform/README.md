# EKS Cluster Terraform Configuration

This directory contains Terraform configurations for creating an EKS cluster with a VPC for the voting application.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version >= 1.2.0)
- kubectl installed
- aws-iam-authenticator installed

## Configuration

The configuration creates:
- A VPC with public and private subnets
- An EKS cluster with a managed node group
- Necessary IAM roles and policies
- Security groups and networking components

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. Configure kubectl:
```bash
aws eks update-kubeconfig --name voting-app-eks --region us-west-2
```

5. Verify cluster access:
```bash
kubectl get nodes
```

## Variables

Key variables can be modified in `terraform.tfvars`:

- `aws_region`: AWS region (default: us-west-2)
- `environment`: Environment name (default: dev)
- `vpc_name`: VPC name (default: voting-app-vpc)
- `vpc_cidr`: VPC CIDR block (default: 10.0.0.0/16)
- `cluster_name`: EKS cluster name (default: voting-app-eks)
- `kubernetes_version`: Kubernetes version (default: 1.27)

## Outputs

After applying the configuration, you can view the outputs using:
```bash
terraform output
```

Key outputs include:
- Cluster endpoint
- Cluster security group ID
- VPC ID
- Subnet IDs
- IAM role information

## Cleanup

To destroy all created resources:
```bash
terraform destroy
```

## Security Considerations

- The cluster endpoint is publicly accessible
- Node groups use t3.small instances for cost optimization
- NAT gateway is used for private subnet internet access
- Security groups are created with minimal required access

## Cost Optimization

- Uses t3.small instances for node groups
- Single NAT gateway for cost savings
- Minimal node group size (1-2 nodes)
- Uses only 2 availability zones 