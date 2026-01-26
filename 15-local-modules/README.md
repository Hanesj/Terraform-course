A networking module that should:

1. Create a VPC with a given cidr block.
2. Allow the user to provide the configuration for multiple subnets:
   1. the user should be able to mark a subnet as public or private
      1. If at least one subnet is public, we need to plaoy and IGW
      2. We need to associate the public subnets with a public RTB
   2. The user should be able to provide cidr blocks
   3. The user should be able to provide AWS AZ
3. The module should be easily reusable.
