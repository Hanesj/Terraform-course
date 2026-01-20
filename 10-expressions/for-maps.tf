locals {
  doubles_map  = { for key, value in var.numbers_map : key => "${key}-${value}" }
  doubles_map2 = { for key, value in var.numbers_map : key => value * 2 }
  doubles_map3 = { for key, value in var.numbers_map : key => value * 2 if value % 2 == 0 }
}

output "map" {
  value = local.doubles_map

}
output "map2" {
  value = local.doubles_map2

}
output "map3" {
  value = local.doubles_map3

}