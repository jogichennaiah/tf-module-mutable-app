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
       "ansible-pull -U https://github.com/jogichennaiah/ansible.git -e ENV=dev -COMPONENT=${var.COMPONENT} roboshop-pull.yml"
    ]
  }
}