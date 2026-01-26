locals {
  name = "Sune Ingo"
  age = 22

  my_object = {
    k1 = 10
    k2 = "val"
  }
}

output "ex1" {
    value = upper(local.name)
  
}
output "ex2" {
    value = base64encode(local.name)
  
}

output "ex3" {
    value = yamldecode(file("${path.module}/users.yaml")).users[*]
  
}

output "ex4" {
    value = yamlencode(local.my_object)
  
}