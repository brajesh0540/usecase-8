variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  
}

variable "public_subnets" {
  description = "List of public subnets for the VPC"
  type        = list(string)
  
}

variable "private_subnets" {
  description = "List of private subnets for the VPC"
  type        = list(string)
  
}

variable "alb_sg_name" {
  description = "Security group ID for the ALB"
  type        = string
  
}

variable "ecs_sg_name" {
  description = "Security group ID for the ECS service"
  type        = string
  
}

variable "ecr_repo_name" {
  description = "The desired number of instances for the ECS service"
  type        = number
  default     = 1
  
}



