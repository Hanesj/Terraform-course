locals {
    # splats kan endast anvandas for listor
    firstname_from_splat = var.objects_list[*].firstname
    # roles_from_splat = local.users_map3[*].roles
     roles_from_splat = values(local.users_map3)[*].roles
}

output "fnames" {
    value = local.firstname_from_splat
  
}
output "roles" {
    value = local.roles_from_splat
  
}