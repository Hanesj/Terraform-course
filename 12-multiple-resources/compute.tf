# resource "aws_instance" "from_count" {
#   count = var.ec2_instance_count
#   ami   = "ami-id"

#   instance_type = "t2.micro"

#   tags = {
#     project = local.project
#   }
# }

# resource "proxmox_vm_qemu" "from_count" {
#   count       = var.ec2_instance_count
#   vmid        = 2000 + count.index
#   name        = "debian-${count.index + 1}"
#   target_node = "proxmox"
#   clone       = "debian-micro-cloud"
#   full_clone  = true

#   startup_shutdown {
#     order            = -1
#     startup_delay    = -1
#     shutdown_timeout = -1
#   }

#   lifecycle {
#     create_before_destroy = true
#     ignore_changes        = [tags]
#   }

#   memory = 512
#   cpu {
#     cores   = 1
#     sockets = 1
#     type    = "host"
#   }
#   scsihw = "virtio-scsi-pci"

#   disks {
#     scsi {
#       scsi0 {
#         disk {
#           size      = "10G"
#           storage   = "local-lvm"
#           replicate = true
#         }
#       }
#     }
#     ide {
#       ide0 {
#         cloudinit {
#           storage = "local-lvm"
#         }
#       }
#     }
#   }
#   network {
#     id     = 0
#     model  = "virtio"
#     bridge = "vmbr1"


#   }
#   serial {
#     id   = 0
#     type = "socket"
#   }

#   os_type    = "cloud-init"
#   ipconfig0  = "ip=10.0.0.11${count.index}/24,gw=10.0.0.1"
#   ciuser     = "debian"
#   cipassword = "debianpass"

#   agent = 1

# }

locals {

}
# resource "proxmox_vm_qemu" "from_list" {
#   count       = length(var.ec2_instance_config)
#   vmid        = 3000 + count.index
#   name        = "${var.ec2_instance_config[count.index].name}-${count.index + 1}"
#   target_node = "proxmox"
#   clone       = var.ec2_instance_config[count.index].clone
#   full_clone  = var.ec2_instance_config[count.index].full_clone

#   startup_shutdown {
#     order            = -1
#     startup_delay    = -1
#     shutdown_timeout = -1
#   }

#   lifecycle {
#     create_before_destroy = true
#     ignore_changes        = [tags]
#   }

#   memory = 512
#   cpu {
#     cores   = var.ec2_instance_config[count.index].cores
#     sockets = var.ec2_instance_config[count.index].sockets
#     type    = "host"
#   }
#   scsihw = var.ec2_instance_config[count.index].scsihw
#   disks {
#     scsi {
#       scsi0 {
#         disk {
#           size      = "10G"
#           storage   = "local-lvm"
#           replicate = true
#         }
#       }
#     }
#     ide {
#       ide0 {
#         cloudinit {
#           storage = "local-lvm"
#         }
#       }
#     }
#   }
#   network {
#     id     = var.ec2_instance_config[count.index].network.id
#     model  = var.ec2_instance_config[count.index].network.model
#     bridge = var.ec2_instance_config[count.index].network.bridge


#   }
#   serial {
#     id   = 0
#     type = "socket"
#   }

#   os_type    = var.ec2_instance_config[count.index].os_type
#   ipconfig0  = "ip=10.0.0.11${count.index}/24,gw=10.0.0.1"
#   ciuser     = var.ec2_instance_config[count.index].ciuser
#   cipassword = var.ec2_instance_config[count.index].cipassword

#   agent = 1

# }

resource "proxmox_vm_qemu" "from_map" {
  for_each = var.ec2_instance_config_map
  vmid        = 3000 + each.value.id
  name        = each.key
  target_node = "proxmox"
  clone       = each.value.clone
  full_clone  = each.value.full_clone

  startup_shutdown {
    order            = -1
    startup_delay    = -1
    shutdown_timeout = -1
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }

  memory = 512
  cpu {
    cores   = each.value.cores
    sockets = each.value.sockets
    type    = "host"
  }
  scsihw = each.value.scsihw
  disks {
    scsi {
      scsi0 {
        disk {
          size      = "10G"
          storage   = "local-lvm"
          replicate = true
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }
  network {
    id     = each.value.network.id
    model  = each.value.network.model
    bridge = each.value.network.bridge


  }
  serial {
    id   = 0
    type = "socket"
  }

  os_type    = each.value.os_type
  ipconfig0  = "ip=10.0.0.${each.value.id}/24,gw=10.0.0.1"
  ciuser     = each.value.ciuser
  cipassword = each.value.cipassword

  agent = 1

}

output "length" {
  value     = proxmox_vm_qemu.from_map
  sensitive = true

}

output "vm_info" {
  value     = {for key, vm in proxmox_vm_qemu.from_map : key => vm.default_ipv4_address}
  sensitive = false
}