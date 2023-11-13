# Injecting the schema
resource "null_resource" "app" {
  count                   = local.INSTANCE_COUNT

  provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE-PRIVATE-IPS, count.index)
  }

    inline = [
      "echo hai"
    ]
  }
}