output "alb_security_group_id" {
    value = module.alb-security-group.security_group_id
}

output "ecs_security_group_id" {
    value = module.ecs-security-group.security_group_id
  
}

output "grafana_security_group_id" {
  value = module.grafana-security-group.security_group_id
}