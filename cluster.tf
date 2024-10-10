# To create cluster
resource "aws_eks_cluster" "example" {
  name     = "rushi"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = ["subnet-01615eb4b9dbe7f10","subnet-00d95ed20e91d3a27"]
  }
}
output "eks_config_file" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}

output "eks_endpoint" {
  value = aws_eks_cluster.example.endpoint
}
