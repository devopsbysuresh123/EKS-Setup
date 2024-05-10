variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "eks_cluster_name" {
  default     = "eks-dr"
  description = "Name of the EKS cluster"
}

variable "k8s_version" {
  default     = "1.25"
  description = "Version of k8s cluster"
}

variable "node_group_name" {
  description = "Name of the EKS node group"
}

variable "vpc_id" {
  description = "Name of the EKS node group"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_desired_size" {
  description = "Desired number of nodes in the node group"
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimum number of nodes in the node group"
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum number of nodes in the node group"
  default     = 3
}

variable "instance_type" {
  description = "Instance type for the EKS node group"
  type        = string
  default     = "t2.micro"  # You can set a default value if needed
}

variable "eks_node_group_role_name" {
  description = "Name of the IAM role for the EKS node group"
  type        = string
  default     = "eks-dr-node-group"  # You can set a default value if needed
}

variable "eks_cluster_role_name" {
  description = "Name of the IAM role for the EKS main cluster control plane"
  type        = string
  default     = "eks-cluster-main-v"  # You can set a default value if needed
}

variable "policy_arns" {
  type    = list(string)
  description = "List of policy ARNs to attach for node group role"
}

variable "addons" {
  type    = map(string)
  description = "Map of add-on names and versions"
}