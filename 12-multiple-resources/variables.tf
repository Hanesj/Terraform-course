variable "subnet_count" {
  type    = number
  default = 3
}

variable "ec2_instance_count" {
  type    = number
  default = 2

}

variable "ec2_instance_config" {
  type = list(object({
    memory = number
    cores = number
    os_type = string
  }))
}