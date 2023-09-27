
provider "aws" {
  region = "us-east-1" 
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key 
}

module "security_group" {
  source = "C:/Users/Zaineb/NEW-TERRAFORM/Modules/Secuirty groups"
  security_group_name_prefix = "ProjectA-"
}
module "vpc" {

  source = "C:/Users/Zaineb/NEW-TERRAFORM/modules/VPC"
   vpc_id = module.vpc.vpc_id
   vpc_cidr_block = "10.0.0.0/16"
   vpc_name       = "ProjectA-VPC"
   igw_id = module.vpc.igw_id
   
   
  
}
module "subnet" {
  source = "C:/Users/Zaineb/NEW-TERRAFORM/modules/Subnets"
  vpc_id = module.vpc.vpc_id
  availability_zones = ["us-east-1a", "us-east-1b"]
  subnet_id    = module.subnet.public_subnet_ids 
  public_subnets = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
 
  private_subnets = {
    "us-east-1a" = "10.0.100.0/24"
    "us-east-1b" = "10.0.101.0/24"
  }
}

locals {
  ec2_instance_count = 2
}

module "ec2" {
  source = "C:/Users/Zaineb/NEW-TERRAFORM/modules/EC2"
  instance_count = local.ec2_instance_count
  subnet_ids    = module.subnet.public_subnet_ids 
  ami_id        = "ami-06ca3ca175f37dd66"  
  instance_type = "t2.micro"
  instance_name = "ProjectA-EC2-Instance"
}

module "rds" {
  source = "C:/Users/Zaineb/NEW-TERRAFORM/Modules/RDS"
  subnet_ids_map  = module.subnet.public_subnet_ids
  rds_instance_id = "mydbinstance"
  rds_username    = "admin"
  rds_password    = "StrongP##sswrd1"
  instance_class = "db.t2.micro"
}

module "iam_user" {
  source     = "C:/Users/Zaineb/NEW-TERRAFORM/Modules/IAM"
  users = {
    developer   = "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    qa          = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
    production  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
}

output "iam_user_names" {
  value = module.iam_user.user_names
}

module "ECR" {
  source = "C:/Users/Zaineb/NEW-TERRAFORM/Modules/ECR"
  repository_name = "my-ecr-repo"  
  image_retention_days = 60  
}


module "alb" {
  source       = "C:/Users/Zaineb/NEW-TERRAFORM/Modules/ALB"
  alb_name     = "my-application-alb"  
  alb_internal = false  
  subnets      = module.subnet.public_subnet_ids 
}