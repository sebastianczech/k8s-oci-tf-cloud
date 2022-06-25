resource "time_sleep" "wait_60_seconds" {
  depends_on = [
    null_resource.master_setup,
    null_resource.worker_setup
  ]

  triggers = {
    always_run = "${timestamp()}"
  }

  # create_duration = "60s"
  create_duration = "1s"
}

resource "null_resource" "k8s_cluster_setup" {
  depends_on = [
    time_sleep.wait_60_seconds
  ]

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

  provisioner "remote-exec" { inline = ["echo 'Starting adding nodes to cluster, where master is node with IP ${self.triggers.public_ip}'"] }

}

# data "external" "join_node_to_cluster" {
#   count = length(var.compute_instances.public_ip) > 1 ? length(var.compute_instances.public_ip) - 1 : 0

#   depends_on = [
#     null_resource.k8s_cluster_setup
#   ]

#   program = ["python3", "${path.module}/scripts/microk8s_cluster.py"]

#   query = {
#     master_public_ip = var.compute_instances.public_ip[0]
#     worker_public_ip = var.compute_instances.public_ip[count.index + 1]
#     worker_name      = var.compute_instances.name[count.index + 1]
#   }
# }

data "external" "get_ip_addres_using_python" {
  program = ["python3", "${path.module}/scripts/microk8s_cluster.py"]
  query = {
    p_env = "qa"
  }
}
