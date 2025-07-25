variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "my-ecr-repo"
  
}