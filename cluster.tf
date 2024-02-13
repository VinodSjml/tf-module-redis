resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "roboshop-${var.ENV}-redis"
  engine               = "redis"
  node_type            = "cache.t3.small"
  num_cache_nodes      = 1
  parameter_group_name = aws_db_parameter_group.redis-pg.name
  engine_version       = "6.2"
  port                 = 6379
  security_group_ids   = [aws_security_group.allows_redis.id]
}

resource "aws_db_parameter_group" "redis-pg" {
  name   = "roboshop-${var.ENV}-redis-pg"
  family = "redis6.x"
}

