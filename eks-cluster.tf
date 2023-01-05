module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.2"

  cluster_name    = local.cluster_name
  cluster_version = "1.23"

### read using data object
  vpc_id     = data.aws_vpc.selected.id
  subnet_ids = data.aws_subnets.private.ids

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

    attach_cluster_primary_security_group = true

    # Disabling and using externally provided security groups
    create_security_group = false
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 1

      pre_bootstrap_user_data = <<-EOT
      echo 'foo bar'
      EOT

      vpc_security_group_ids = [
        data.aws_security_groups.node_group_one.id
      ]
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.medium"]

      min_size     = 0
      max_size     = 1
      desired_size = 0

      pre_bootstrap_user_data = <<-EOT
      echo 'foo bar'
      EOT

      vpc_security_group_ids = [
        data.aws_security_groups.node_group_two.id
      ]
    }
  }

  # tags = var.tags

  tags = {
    Application    = "Kubernetes"
    BusinessUnit   = "Research and Development"
    Classification = "Internal"
    Environment    = "dev"
  }
}
