# Creats backend component Record against the ALB

resource "aws_route53_record" "docdb_dns" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
  name    = "${var.COMPONENT}.${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = var.INTERNAL ? [data.terraform_remote_state.alb.outputs.PRIVATE_HOSTED_ZONE_ID] : data.terraform_remote_state.alb.outputs.PUBLIC_HOSTED_ZONE_ID
}

