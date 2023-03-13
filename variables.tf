variable "cluster_name" {
    description = "ECS cluster name"
    default = "FotoPie-with-Fargate"
  
}

variable "task_definition_family_name" {
    description = "task definition name"
    default = "fotopie_task"
  
}

variable "image_name" {
    description = "Image name for the task definition to run in this ECS cluster"
    default = "fotopie"
  
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
  default     = "fotopie"
  
}

variable "container_port" {
  description = "port number for the container"
  default     = 9090
  
}

variable "default_vpc_id" {
    description = "ID of default VPC"
    default = "vpc-04936b1b1afaf216b"
  
}

variable "default_subnets" {
   description = "Default subnets of default VPC"
   default = ["subnet-03f4255fcf5fc7182", "subnet-036a34e6087ab39c9", "subnet-0c0a830e181655379"]
}