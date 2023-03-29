provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "fyp-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"

  cluster_name    = local.cluster_name
  cluster_version = "1.23"

  vpc_id     = aws_vpc.fyp-vpc.id
  subnet_ids = [aws_subnet.fyp-subnet-1.id, aws_subnet.fyp-subnet-2.id, aws_subnet.fyp-subnet-3.id]

  node_security_group_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = null
  }

  eks_managed_node_group_defaults = {
    ami_type                              = "AL2_x86_64"
    attach_cluster_primary_security_group = true
    create_security_group                 = false
  }

  eks_managed_node_groups = {
    one = {
      name                    = "node-group-1"
      instance_types          = ["t3.xlarge"]
      min_size                = 1
      max_size                = 1
      desired_size            = 1
      pre_bootstrap_user_data = <<-EOT
      EOT
      vpc_security_group_ids = [
        aws_security_group.fyp-sg.id
      ]
      key_name = var.key_name
    }
    two = {
      name                    = "node-group-2"
      instance_types          = ["t3.xlarge"]
      min_size                = 1
      max_size                = 1
      desired_size            = 1
      pre_bootstrap_user_data = <<-EOT
      EOT
      vpc_security_group_ids = [
        aws_security_group.fyp-sg.id
      ]
      key_name = var.key_name
    }
  }
}
