add-ons.tf
resource "aws_eks_addon" "eks_addons" {
  for_each      = var.addons
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = each.key
  addon_version = each.value
}