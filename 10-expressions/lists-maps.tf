locals {
  users_map  = { for user in var.users : user.username => { role = user.role }... }
  users_map2 = { for user in var.users : user.username => user.role... }
  users_map3 = { for user, role in local.users_map2 : user => {
    roles = role
    }
  }

  usernames_from_map = [for username, roles in local.users_map: username]
}
output "users" {
  value = local.users_map

}
output "users2" {
  value = local.users_map2

}
output "users3" {
  value = local.users_map3

}

output "user_to_output_roles" {
    value = local.users_map3[var.user_to_output].roles
  
}

output "usernames" {
    value = local.usernames_from_map
  
}