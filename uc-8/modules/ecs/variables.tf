variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster will be created."
  type        = string
  
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the ECS cluster will be created."
  type        = list(string)
  
}

variable "desired_count" {
  description = "The desired number of instances of the task to run."
  type        = number
  default     = 1
  
}

variable "region" {
  description = "The AWS region where the ECS cluster will be created."
  type        = string
  default     = "us-east-1"
  
}

variable "container_port" {
  description = "The port on which the container will listen."
  type        = number
  default     = 80
  
}

variable "image_id" {
  description = "The image ID for the second container in the ECS task."
  type        = string
  
}

variable "alb_listener_arn" {
  description = "The ARN of the ALB listener"
  type        = string
  
}

variable "ecs_target_group_arn" {
  description = "The ARN of the ECS target group"
  type        = string
  
}



