resource "null_resource" "worker_setup" {
  count = length(var.compute_instances.public_ip)

  triggers = {
    public_ip = var.compute_instances.public_ip[count.index]
  }

  connection {
    type        = "ssh"
    host        = self.triggers.public_ip
    user        = "ubuntu"
    private_key = var.id_rsa
    timeout     = "30s"
  }

  provisioner "remote-exec" {
    inline = ["echo 'Running worker init script'"]
  }

  provisioner "remote-exec" {
    inline     = ["mkdir .kube"]
    on_failure = continue
  }
}