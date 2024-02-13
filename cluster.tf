resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_elasticache_parameter_group.redis-pg.name
  engine_version       = "6.2"
  port                 = 6379
  security_group_ids   = [aws_security_group.allows_redis.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis-subnet-group.name
}

resource "aws_elasticache_parameter_group" "redis-pg" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = "redis6.x"
}

resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  name       = "roboshop-${var.ENV}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}


