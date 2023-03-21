module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  cluster_name    = "fotopie-cluster"
  cluster_version = "1.24"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access  = true

  #  Fargate Profile(s)
 fargate_profiles = [
    {
      name = "nginx" // fargate name
      selectors = [
        {
          namespace = "nginx-demo"
        }
      ]
    }
 ]

  # eks_managed_node_groups = {
  #   dev = {
  #     min_size     = 1
  #     max_size     = 3
  #     desired_size = 2

  #     instance_types = ["t2.small"]
  #   }
  # }

  tags = {
    environment = "development"
    application = "fotopie"
  }
}