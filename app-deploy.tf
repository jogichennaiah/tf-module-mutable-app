# Injecting the schema
resource "null_resource" "app" {
  count                   = local.INSTANCE_COUNT

  
    connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE-PRIVATE-IPS, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}