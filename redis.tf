# # create redis elastic cache cluster

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.medium"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.default.name
  subnet_group_name = aws_docdb_subnet_group.redis.name
  security_group_ids = [aws_security_group.allows_redis.id]
  engine_version       = "6.x"
  port                 = 6379
}

# parmater group allows to pass mutliple parameters in one shot 
resource "aws_elasticache_parameter_group" "default" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = "redis6.2"


}

# Creates redis subnet group
resource "aws_docdb_subnet_group" "redis" {
  name       = "roboshop-${var.ENV}-docdb-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
  tags = {
    Name = "roboshop-${var.ENV}-redis-subnet-group"
  }
}



# resource "aws_docdb_cluster" "docdb" {
#   cluster_identifier      = "roboshop-${var.ENV}-docdb"
#   engine                  = "docdb"
#   master_username         = "admin1"
#   master_password         = "roboshop1"
#   #backup_retention_period = 5
#   #preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     = true           #value will be false in production ,if we delete the 
#                                            # database it will take a snap shot in the end

#    db_subnet_group_name = aws_docdb_subnet_group.docdb.name
#    vpc_security_group_ids = [aws_security_group.allows_docdb.id]
# }

# # Creates docdb instances and adds to the cluster
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-${var.ENV}-docdb"
#   cluster_identifier = aws_docdb_cluster.docdb.id
#   instance_class     = "db.t3.medium"
# }


# # Creates docdb subnet group
# resource "aws_docdb_subnet_group" "docdb" {
#   name       = "roboshop-${var.ENV}-docdb-subnet-group"
#   subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

#   tags = {
#     Name = "roboshop-${var.ENV}-docdb-subnet-group"
#   }
# }