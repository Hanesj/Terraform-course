# variable "vpc_cidr" {
#   type = string

#   validation {
#     condition     = can(cidrnetmask(var.vpc_cidr))
#     error_message = "vpc_cidr must contain a valid cidr block."
#   }

# }

# variable "vpc_name" {
#     type = string

# }

variable "vpc_config" {
  type = object({
    cidr_block = string
    name       = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config must contain a valid cidr-block"
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)

  }))

  validation {
    condition = alltrue([
      for subnet in values(var.subnet_config) : can(cidrnetmask(subnet.cidr_block))
    ])
    error_message = "The cidr_block config must contain a valid cidr-block"
  }
}