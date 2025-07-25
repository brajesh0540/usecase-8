module "alb" {
    source = "./modules/alb"
    public_subnet = module.vpc.public_subnet_ids
    vpc_id = module.vpc.vpc_id
  
}

module "vpc" {
    source = "./modules/vpc"
    cidr_block = var.cidr_block
}

module "iam" {
    source = "./modules/iam"
  
}

module "ecs" {
    source = "./modules/ecs"
    image_id = var.image_id
    container_port = var.container_port
    desired_count = var.desired_count
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.public_subnet_ids
    alb_listener_arn = module.alb.alb_listener_arn
    ecs_target_group_arn = module.alb.ecs_target_group_arn
}

output "ecs_target_group_arn" {
  value = module.alb.ecs_target_group_arn
}

