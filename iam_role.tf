# Create IAM Role for EKS
resource "aws_iam_role" "eks_role" {
  name = var.eks_cluster_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach IAM Policies for EKS
resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "eks_policy_attachment_n" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role" "eks_dr_node_group" {
  name = var.eks_node_group_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

#List of policy ARNs to attach for node group role
locals {
  policy_arns = var.policy_arns
}

#Attach policies to the IAM role using dynamic block
resource "aws_iam_policy_attachment" "attach_policies" {
  count      = length(local.policy_arns)
  name       = "policy_attachment_${count.index}"
  policy_arn = local.policy_arns[count.index]
  roles      = [aws_iam_role.eks_dr_node_group.name]
}

data "aws_iam_role" "eks_dr_node_group" {
  name = var.eks_node_group_role_name  # Use the variable here
  depends_on = [aws_iam_role.eks_dr_node_group]
}