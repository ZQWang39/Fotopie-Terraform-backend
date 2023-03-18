module "managed-service-grafana" {
  source  = "terraform-aws-modules/managed-service-grafana/aws"
  version = "1.8.0"

    # Workspace
  name                      = "FotoPie-Backend"
  description               = "Monitor FotoPie backend"
  account_access_type       = "CURRENT_ACCOUNT"
  authentication_providers  = ["AWS_SSO"]
  permission_type           = "SERVICE_MANAGED"
  associate_license         = "true"
  vpc_configuration         = {
        security_group_ids = [module.grafana-security-group.security_group_id]
        subnet_ids         = module.vpc.private_subnets
  }
  data_sources              = ["AMAZON_OPENSEARCH_SERVICE", "ATHENA", "CLOUDWATCH", "REDSHIFT", "SITEWISE", "TIMESTREAM", "PROMETHEUS", "XRAY"]
  notification_destinations = ["SNS"]

  role_associations = {
    "ADMIN_GROUP" = {
      "group_ids" = ["24685468-f0e1-70ef-04ef-d4c7172689b9"]
    }
    "ADMIN_USER" = {
      "user_ids" = ["a4d894f8-60f1-7020-0df7-8c417d67d35d"]
    }
   
  }
}


# resource "aws_grafana_workspace" "fotopie_grafana" {
#   name                     = "FotoPie-Backend"
#   description              = "Monitor FotoPie backend"
#   account_access_type      = "CURRENT_ACCOUNT"
#   authentication_providers = ["AWS_SSO"]
#   permission_type          = "SERVICE_MANAGED"
#   vpc_configuration        = {
#     security_group_ids = [module.grafana-security-group.security_group_id]
#     subnet_ids         = module.vpc.private_subnets
#   }
#   data_sources             = ["AMAZON_OPENSEARCH_SERVICE", "ATHENA", "CLOUDWATCH", "REDSHIFT", "SITEWISE", "TIMESTREAM", "PROMETHEUS", "XRAY"]
#   notification_destinations = ["SNS"]
#   organization_role_name    = "fotopie_ziqi"

# }
