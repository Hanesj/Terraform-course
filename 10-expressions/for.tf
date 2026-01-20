locals {
  doubles    = [for n in var.numbers_list : n * 2]
  even_nums  = [for n in var.numbers_list : n if n % 2 == 0 || n == 1]
  firstnames = [for p in var.objects_list : p.firstname]
  full       = [for per in var.objects_list : "${per.firstname}-${per.lname}"]
}

output "vals" {
  value = {
    dbs  = local.doubles
    even = local.even_nums
  }

}

output "names" {
  value = local.firstnames

}

output "full" {
  value = local.full

}