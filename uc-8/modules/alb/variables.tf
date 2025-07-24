variable "public_subnet" {
    description = "Public subnet for the ALB"
    type        = list(string)
    default     = []
}

variable "private_subnet" {
    description = "Private subnet for the ALB"
    type        = list(string)
    default     = []
}

variable "env" {
    description = "Environment variable for tagging"
    type        = string
    default     = "dev"
  
}

variable "vpc_id" {
    description = "VPC ID where the ALB and target group will be created"
    type        = string
  
}