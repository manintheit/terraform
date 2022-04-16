resource "null_resource" "download_and_resize_qcow2" {
    count = length(var.domains)
    provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "wget -O /data/KVM/${var.domains[count.index]}.qcow2 http://localhost:8000/focal-server-cloudimg-amd64.img && qemu-img resize /data/KVM/${var.domains[count.index]}.qcow2 15G"
  }
}

resource "libvirt_volume" "qcow2-volume" {
  count = length(var.domains)
  name   = "${var.domains[count.index]}.qcow2"
  pool  = var.libvirt_storage_pool
  format = "qcow2"
  depends_on = [
    null_resource.download_and_resize_qcow2
  ]
}

# data "template_file" "user_data" {
#   template = file("${path.module}/config/cloud_init.cfg")
# }

# data "template_file" "network_config" {
#   template = file("${path.module}/config/network_config.cfg")
# }


# for more info about paramater check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
# Use CloudInit to add our ssh-key to the instance
# you can add also meta_data field
resource "libvirt_cloudinit_disk" "commoninit" {
  count = length(var.domains)
  name      = "commoninit-${var.domains[count.index]}.iso"
  user_data = templatefile("${path.module}/templates/user_data.tpl", {
    hostname = var.domains[count.index],
    authorized_keys = file("${path.module}/config/authorized_keys"),

  })
  network_config = templatefile("${path.module}/templates/network_config.tpl",{
    interface = var.interface,
    ipaddr = var.ips[count.index]

  })
  #user_data      = data.template_file.user_data.rendered
  #network_config = data.template_file.network_config.rendered
  pool           = var.libvirt_storage_pool
}

# create a virtual machine named tf-test
resource "libvirt_domain" "qcow2-domain" {
    count = length(var.domains)
    name = var.domains[count.index]
    description = var.domains[count.index]
    vcpu = var.vcpu
    memory = var.memory
  
    cloudinit = element(libvirt_cloudinit_disk.commoninit.*.id, count.index)

 network_interface {
    network_name = var.network
    addresses = [var.ips[count.index]]
    # static ip configured
    wait_for_lease =  false
  }

  disk {
    volume_id = element(libvirt_volume.qcow2-volume.*.id, count.index)
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

}