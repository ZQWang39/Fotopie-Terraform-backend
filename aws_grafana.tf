module "managed-service-grafana" {
  source  = "terraform-aws-modules/managed-service-grafana/aws"
  version = "1.8.0"

    # Workspace
  name                      = "FotoPie-Backend"
  description               = "Monitor FotoPie backend"
  account_access_type       = "CURRENT_ACCOUNT"
  authentication_providers  = ["AWS_SSO"]
  permission_type           = "SERVICE_MANAGED"
  vpc_configuration         = {
        security_group_ids = [module.grafana-security-group.security_group_id]
        subnet_ids         = module.vpc.private_subnets
  }
  data_sources              = ["AMAZON_OPENSEARCH_SERVICE", "ATHENA", "CLOUDWATCH", "REDSHIFT", "SITEWISE", "TIMESTREAM", "PROMETHEUS", "XRAY"]
  notification_destinations = ["SNS"]
}