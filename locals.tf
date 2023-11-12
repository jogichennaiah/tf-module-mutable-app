locals {
    INSTANCE_IDS           =  concat(aws_spot_instance_request.spot.*.spot_instance_id, aws_instance.od.*.id)
    INSTANCE_COUNT         = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
    INSTANCE-PRIVATE-IPS   = concat(aws_instance.od.*.private_ip , aws_spot_instance_request.spot.*.private_ip)
    SSH_USERNAME           = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["SSH_USERNAME"]
    SSH_PASSWORD           = jsondecode(data.aws_secretsmanager_secret_version.secret_version.secret_string)["SSH_PASSWORD"]
}