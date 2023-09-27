
resource "aws_db_instance" "rds_instance" {
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.micro"
    identifier = "my-rds-instance"
    username = var.rds_username
    password = var.rds_password
    parameter_group_name = "default.mysql5.7"
    skip_final_snapshot = true
    publicly_accessible = false
     tags = {
    Name = "MyRDSInstance"
  }
   db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

}

resource "aws_db_subnet_group" "rds_subnet_group" {
    name       = "my-rds-subnet-group"
    subnet_ids = values(var.subnet_ids_map)
}


output "rds_instance_id" {
  value = aws_db_instance.rds_instance
}


