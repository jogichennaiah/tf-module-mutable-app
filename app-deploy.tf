# Injecting the schema
resource "null_resource" "app" {

  triggers = {
    always_run = "${timesstamp()}"                                # This ensure your provisionerwould be executing all the time
  }

  count                   = local.INSTANCE_COUNT

  provisioner "remote-exec" {
    connection {
    type     = "ssh"
    user     = local.SSH_USERNAME
    password = local.SSH_PASSWORD
    host     = element(local.INSTANCE-PRIVATE-IPS, count.index)
  }

    inline = [
      "ansible-pull -U https://github.com/jogichennaiah/ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}