variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

# variable "tags" {
#   description = "Common tags shared across all resources"
#   type = object({
#     Application    = string,
#     BusinessUnit   = string,
#     Classification = string,
#     Environment    = string,
#     Name           = string,
#     SourceMarket   = string,
#     Tier           = string,
#     TechnicalOwner = string,
#     StageName      = string,
#     service        = string
#   })
# }