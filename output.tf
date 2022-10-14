
output "vpc_id" {
  value = module.vpc-prod.vpc_id
}

output "private_subnets_id" {
  value = module.vpc-prod.private_subnets_id
}
