variable "numbers_list" {
  type = list(number)
}

variable "objects_list" {
  type = list(object({
    firstname = string
    lname     = string
  }))
}

variable "numbers_map" {
  type = map(number)

}

variable "users" {
  type = list(object({
    username = string
    role     = string
  }))
}

variable "user_to_output" {
    type = string
  
}
