resource "aws_iam_role" "EksFargateProfileRole" {
  name = "eks-fargate-profile-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.EksFargateProfileRole.name
}

resource "aws_eks_fargate_profile" "fotopie_fargate" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "nginx"
  pod_execution_role_arn = aws_iam_role.EksFargateProfileRole.arn
  subnet_ids             = module.vpc.private_subnets

  selector {
    namespace = "nginx-demo"
  }
}