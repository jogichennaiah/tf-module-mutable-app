# Creats Target Group

resource "aws_lb_target_group" "app" {
  name     = "${var.COMPONENT}-${var.ENV}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.VPC_ID
}

# Attaches the target group to the LoadBalancer

resource "aws_lb_target_group_attachment" "attach_instnces" {
  count            = local.INSTANCE_COUNT
  target_group_arn = aws_lb_target_group.app.arn
  target_id        = element(local.INSTANCE_IDS, count.index)
  port             = 8080
}