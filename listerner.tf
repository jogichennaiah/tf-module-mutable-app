# This creates the listener and adds to the priavte ALB

resource "aws_lb_listener" "private" {
  count             = var.INTERNAL ? 1:0

  load_balancer_arn =  data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ARN

  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
    
  }
}


# Creats a rule in the private LoadBalancer Listtner
resource "aws_lb_listener_rule" "app_rule" {
  count               = var.INTERNAL ? 1 : 0

  listener_arn        = aws_lb_listener.private.*.arn[0]
  priority            = 99

  action {
    type              = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    host_header {
      values = ["${var.COMPONENT}-${var.ENV}.data.data.terraform_remote_state.vpc.PRIVATE_HOSTED_ZONE_NAME"]
    }
  }
}