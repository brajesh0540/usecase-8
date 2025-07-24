variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  
}

variable "image_id" {
  description = "The image ID for the second container in the ECS task."
  type        = string
  
}

variable "container_port" {
    description = "The port on which the container will listen."
    type        = number
    default     = 80
  
}

variable "desired_count" {
    description = "The desired number of instances of the task to run."
    type        = number
    default     = 1
  
}

variable "alb_listener_arn" {
  description = "ARN of the ALB listener for ECS service"
  type        = string
  
}

