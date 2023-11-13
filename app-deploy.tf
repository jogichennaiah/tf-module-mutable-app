# Injecting the schema
resource "null_resource" "app" {

  triggers = {
    always_run = "${timestamp()}"                                # This ensure your provisionerwould be executing all the time
  }

  count                   = local.INSTANCE_COUNT

  provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE_PRIVATE_IPS, count.index)
  }

    inline = [
      "sleep  30",
      "ansible-pull -U https://github.com/jogichennaiah/ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}