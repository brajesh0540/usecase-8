output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.ecs_alb.dns_name
  
}

output "target_group_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb_target_group.ecs_target_group.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.alb_listener_arn.arn
}

output "ecs_target_group_arn" {
  value = aws_lb_target_group.ecs_target_group.arn
}