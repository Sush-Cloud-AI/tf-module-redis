##adding cname record for redis endpoint
##in redis if there 2 nodes then there will be two end points we have decide 
##which endpoint we use

resource "aws_route53_record" "redis_dns" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  name    = "redis-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_NAME}"
  type    = "CNAME"
  ttl     = 10
  records = [aws_elasticache_cluster.redis.cache_nodes.0.address]
}


##for debug to get the node details
# output "redis" {
# value = aws_elasticache_cluster.redis
  
# }