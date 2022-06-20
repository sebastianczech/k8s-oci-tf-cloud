resource "null_resource" "worker_setup" {
  count = length(var.compute_instances.public_ip) > 1 ? length(var.compute_instances.public_ip) - 1 : 0

  triggers = {
    public_ip  = var.compute_instances.public_ip[count.index + 1]
    always_run = "${timestamp()}"
  }

  connection {
    type        = "ssh"
    host        = self.triggers.public_ip
    user        = "ubuntu"
    private_key = var.id_rsa
    timeout     = "30s"
  }

  provisioner "remote-exec" { inline = ["echo 'Running worker init script on worker node ${count.index} with IP ${self.triggers.public_ip}'"] }

  # provisioner "remote-exec" { inline = ["mkdir -p scripts"] }

  # provisioner "file" {
  #   content     = file("${path.module}/scripts/install.sh")
  #   destination = "scripts/install.sh"
  # }

  # provisioner "remote-exec" { inline = ["chmod 0777 scripts/install.sh"] }

  # provisioner "remote-exec" { inline = ["scripts/install.sh"] }

  provisioner "remote-exec" { inline = [file("${path.module}/scripts/install.sh")] }

}