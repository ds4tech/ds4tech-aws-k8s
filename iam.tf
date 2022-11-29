module "cluster_autoscaler_irsa_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name                        = "cluster-autoscaler"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_ids   = [module.eks.cluster_id]

  oidc_providers = {
    one = {
    #   provider_arn               = "arn:aws:iam::311744426619:oidc-provider/oidc.eks.eu-central-1.amazonaws.com/id/BFC2A04D617EF4CA1172B3BC5F3DA2F7"
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
#   role_policy_arns = {
#     AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#     additional           = aws_iam_policy.additional.arn
#   }

  tags = local.tags
}

# module "velero_irsa_role" {
#   source = "../../modules/iam-role-for-service-accounts-eks"

#   role_name             = "velero"
#   attach_velero_policy  = true
#   velero_s3_bucket_arns = ["arn:aws:s3:::velero-backups"]

#   oidc_providers = {
#     ex = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["velero:velero"]
#     }
#   }

#   tags = local.tags
# }

# module "external_dns_irsa_role" {
#   source = "../../modules/iam-role-for-service-accounts-eks"

#   role_name                     = "external-dns"
#   attach_external_dns_policy    = true
#   external_dns_hosted_zone_arns = ["arn:aws:route53:::hostedzone/IClearlyMadeThisUp"]

#   oidc_providers = {
#     ex = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:external-dns"]
#     }
#   }

#   tags = local.tags
# }

################################################################################
# Supporting Resources
################################################################################

resource "aws_iam_policy" "additional" {
  name        = "${local.cluster_name}-additional"
  description = "Additional test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = local.tags
}