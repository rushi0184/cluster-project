# To create nodegroup
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "example"
  disk_size = 20
  instance_types = ["t2.medium"]
  node_role_arn   = aws_iam_role.eks-nodegroup-role.arn
  subnet_ids      = ["subnet-01615eb4b9dbe7f10","subnet-00d95ed20e91d3a27"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_ng_role_policy_AmazonEKSWorkerNodePolicy,
  aws_iam_role_policy_attachment.eks_ng_role_policy_AmazonEKS_CNI_Policy,
  aws_iam_role_policy_attachment.eks_ng_role_policy_AmazonEC2ContainerRegistryReadOnly
  ]
}