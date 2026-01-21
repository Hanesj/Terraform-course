variable "subnet_count" {
  type    = number
  default = 3
}

variable "ec2_instance_count" {
  type    = number
  default = 2

}

# variable "ec2_instance_config" {
#   type = list(object({
#     memory     = number
#     cores      = number
#     sockets    = number
#     os_type    = string
#     name       = string
#     clone      = string
#     full_clone = bool
#     scsihw     = string
#     network = object({
#       id     = number
#       model  = string
#       bridge = string
#     })
#     ciuser     = string
#     cipassword = string
#   }))

#   validation {
#     error_message = "Only debian-micro-cloud allowed."
#     condition = alltrue([for conf in var.ec2_instance_config : contains(["debian-micro-cloud"]
#     , conf.clone)])
#   }
# }
variable "ec2_instance_config_map" {
  type = map(object({
    memory     = number
    cores      = number
    sockets    = number
    os_type    = string
    name       = string
    clone      = string
    full_clone = bool
    scsihw     = string
    network = object({
      id     = number
      model  = string
      bridge = string
    })
    ciuser     = string
    cipassword = string
    id         = number
  }))

  validation {
    error_message = "Only debian-micro-cloud allowed."
    condition = alltrue([for conf in values(var.ec2_instance_config_map) :
     contains(["debian-micro-cloud"]
    , conf.clone)])
  }
  # Kan ha multipla validations
  # validation {
  #   error_message = "Error"
  #   condition = false
  # }
}