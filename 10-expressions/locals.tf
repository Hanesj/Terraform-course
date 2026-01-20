locals {
  math       = 2 * 2
  equality   = 2 == 2 # == !=
  comparison = 2 > 1  # 1 >= 2
  logical    = !true  # && || 
}

output "operators" {
  value = {
    math = local.math
    eq   = local.equality
    cmp  = local.comparison
    lgc  = local.logical
  }
}