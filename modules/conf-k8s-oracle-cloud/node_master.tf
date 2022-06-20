resource "null_resource" "master_setup" {
  triggers = {
    public_ip  = var.compute_instances.public_ip[0]
    always_run = "${timestamp()}"
  }

  connection {
    type        = "ssh"
    host        = self.triggers.public_ip
    user        = "ubuntu"
    private_key = var.id_rsa
    timeout     = "30s"
  }

  provisioner "remote-exec" { inline = ["echo 'Running worker init script on master node with IP ${self.triggers.public_ip}'"] }

  provisioner "remote-exec" { inline = [file("${path.module}/scripts/install.sh")] }

  provisioner "file" {
    content     = templatefile("${path.module}/files/rules.v4", { my_public_ip = var.my_public_ip })
    destination = "/tmp/rules.v4"
  }

  provisioner "remote-exec" { inline = ["sudo cp /tmp/rules.v4 /etc/iptables/rules.v4"] }

}