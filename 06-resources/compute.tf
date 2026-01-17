# resource "aws_instance" "web" {
#   ami                         = "ami-0f27749973e2399b6"
#   associate_public_ip_address = true
#   instance_type               = "t2.micro"

#   subnet_id = aws_subnet.public.id
#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 10
#     volume_type           = "gp3"
#   }
# }
resource "proxmox_vm_qemu" "debian-1" {
  name        = "debian-1"
  target_node = "proxmox"
  clone       = "debian-micro-cloud"
  full_clone  = true
  agent       = 1


  memory  = 512
  cpu {
    cores   = 1
    sockets = 1
    type = "host"
  }
  scsihw  = "virtio-scsi-pci" 

  disks {
    scsi{
        scsi0{
            disk {
              size = "10G"
              storage = "local-lvm"
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
    id = 0
    model  = "virtio"
    bridge = "vmbr0"
  }
  skip_ipv6 = true
  serial {
    id = 0
    type = "socket"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=dhcp"
  ciuser    = "debian"
  cipassword = "debian"
  sshkeys   = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHHG3BLUoyf0pOXJjxgW8vKx07nyqOzeIkbigBouihikFm9DG4H905xRk4a/5mOOGHc1SSiJfwAvDlk23/cqErbb13A8LQyow5Dvtxf56I+4qcSBF7OtAY1EbI27ektaa5I//KX4vaAlhAYt7CXFByyKHo4znA9jftJLDKtR/C7eG4p7iMYnrwDneBrMmhwTK1xW7t5qymbbjFuvizKbUnxb62OeFzOb743J+QJx8Vzf7e2twLbqTaZK8vk+nMFRAW/le0cL04Z+Mf7VbC1qV5m9zGPB2IG/jyGZQ20IkSOCRw4eeOAYamvjoqUIY2H3jnNUsDRGjHk+577XI6aubxbsL2M2h8fCYbTI73mF9CO/7+kkEL9k2jLyC6KdJ+ymqpOKewJtWwUeU/3/z/IgTLi0XKDyH6u8NdUs15axRb3T0Ux/NpdFZdJYdtJwY+Xum2ohDaO9SxQIQEH9duvIAz6zs8ogisbKi5jC2mEP8Zp45T/IO+gnVmwS1hcoE0+4ReeVll+5RvodUu62WX3EByemerWnAH9Igjt8NkANKRj4NSvzEaS60QLQGzzVrZ6cAhw6v2mvRIxzJjiJ4oj0eyk/6KZVPpZNa8yh5i0KVG9z/X8f3zcHPS1l9rxUtQKd1358lBEueYR1ySQPDFUTsvB+q4yRi8Uw698wWjEQzoeQ== hane@hane-mint
  EOF
}