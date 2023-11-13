# # Create App Component Record against the ALB 
resource "aws_route53_record" "alb_arn" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID : data.terraform_remote_state.vpc.outputs.PUBLIC_HOSTED_ZONE_ID
  name    = "${var.COMPONENT}-${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = var.INTERNAL ? [data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ARN] : [data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ARN]
}