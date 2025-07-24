module "alb" {
    source = "./modules/alb"
    vpc_id = module.vpc.vpc_id
    public_subnet = module.public_subnet.subnet_id
  
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
    subnet_ids = module.public_subnet.subnet_ids
}

module "ecr_patient" {
    source = "./modules/microservices/patient-service"
    repository_name = "patient-service-repo"
}

module "ecr_appointment" {
    source = "./modules/microservices/appointment-service"
    repository_name = "appointment-service-repo"
  
}

