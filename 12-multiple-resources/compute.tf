# resource "aws_instance" "from_count" {
#   count = var.ec2_instance_count
#   ami   = "ami-id"

#   instance_type = "t2.micro"

#   tags = {
#     project = local.project
#   }
# }

resource "proxmox_vm_qemu" "from_count" {
  count       = var.ec2_instance_count
  vmid = 2000 + count.index
  name        = "debian-${count.index + 1}"
  target_node = "proxmox"
  clone       = "debian-micro-cloud"
  full_clone  = true

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
    cores   = 1
    sockets = 1
    type    = "host"
  }
  scsihw = "virtio-scsi-pci"

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
    id     = 0
    model  = "virtio"
    bridge = "vmbr1"


  }
  serial {
    id   = 0
    type = "socket"
  }

  os_type    = "cloud-init"
  ipconfig0  = "ip=10.0.0.11${count.index}/24,gw=10.0.0.1"
  ciuser     = "debian"
  cipassword = "debianpass"

  agent = 1

}

output "vm_info" {
  value     = proxmox_vm_qemu.from_count[*].default_ipv4_address
  sensitive = false
}