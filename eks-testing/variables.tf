
variable "fotopie_vpc" {
    description = "VPC name for FotoPie dev environment"
    default = "fotopie-vpc-dev"
}

variable "vpc_cidr" {
    description = "CIDR block for vpc"
    default = "172.10.0.0/16"
}

variable "private_subnets_cidr" {
    description = "private subnets cidr blocks" 
    default = ["172.10.1.0/24", "172.10.2.0/24"]
}

variable "public_subnets_cidr" {
    description = "public subnets cidr blocks" 
    default = ["172.10.11.0/24", "172.10.12.0/24"]
}

variable "fotopie_alb_sg" {
    description = "Security group name for FotoPie backend ALB"
    default = "fotopie_alb_sg"
}

variable "fotopie_ecs_service_sg" {
    description = "Security group name for FotoPie backend ECS service/container"
    default = "fotopie_ecs_service_sg"
}

variable "cluster_name" {
    description = "ECS cluster name"
    default = "FotoPie-with-Fargate"
  
}

variable "task_definition_family_name" {
    description = "task definition name"
    default = "fotopie_backend_task"
  
}

variable "image_name" {
    description = "Image name for the task definition to run in this ECS cluster"
    default = "fotopie-backend"
  
}

variable "image_uri" {
    description = "arn for the image"
    default = "206053821616.dkr.ecr.ap-southeast-2.amazonaws.com/fotopie:latest"
}

variable "irequires_compatibilities" {
    description = "Set of launch types required by the task. The valid values are EC2 and FARGATE"
    default = ["FARGATE"]
}

variable "fargate_cpu" {
    description = "fargate instacne CPU units to provision, my requirent 1 vcpu so gave 1024"
    default = 1024
}

variable "fargate_memory" {
    description = "Fargate instance memory to provision (in MiB) not MB"
    default = 2048
}

variable "app_port" {
  description = "portexposed on the docker image"
  default     = 9090
  
}

variable "ecs_service_name" {
  description = "ECS service name"
  default     = "fotopie_service"
  
}

variable "service_launch_type" {
  description = "Launch type for service"
  default     = "FARGATE"
  
}

variable "desired_tasks" {
  description = "The count of desired tasks"
  default     = 2
  
}

variable "container_name" {
  description = "container name of the image"
  default     = "fotopie-backend"
  
}

variable "container_port" {
  description = "port number for the container"
  default     = 9090
  
}

variable "my_ip_address" {
  description = "My local IP adress"
  default     = "149.167.135.253/32"
}

variable "aws_group_id" {
  description = "Group id for aws sso, IAM Identity Center (successor to AWS Single Sign-On). Manage workforce access to multiple AWS accounts and cloud applications."
  default     = ["24685468-f0e1-70ef-04ef-d4c7172689b9"]
}

variable "aws_user_id" {
  description = "user id for aws SSO."
  default     = ["a4d894f8-60f1-7020-0df7-8c417d67d35d"]
}