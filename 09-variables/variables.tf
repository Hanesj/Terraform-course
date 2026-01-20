variable "PM_API" {
  type      = string
  sensitive = true

}

# variable "ec2_volume_type" {
#   type = string
# }

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Size of EC2 instance."

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type) || var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    error_message = "Only t2- or t3.micro"
  }
}

variable "ec2_volume_size" {
  type    = number
  default = 10

}

variable "startsWith" {
  type        = string
  description = "startswith condition"

  validation {
    condition     = startswith(var.startsWith, "t3")
    error_message = "Only supports t3"
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string
  })

  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}

locals {
  owner       = "terraform-course"
  cost_center = "1234"
  managed_by  = "terraform"
}

locals {
  common_tags = {
    owner       = local.owner
    cost_center = local.cost_center
    managed_by  = local.managed_by

  }
}