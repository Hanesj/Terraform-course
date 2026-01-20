# resource "aws_instance" "compute" {
#   ami           = "03asd3aood"
#   instance_type = var.ec2_instance_type

#   root_block_device {
#     volume_size = var.ec2_volume_config.size
#     volume_type = var.ec2_volume_type
#   }

#   tags = merge(var.additional_tags, {
#     ManagedBy = "Terraform"
#   })

# }
