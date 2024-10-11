# Variable for specifying the CIDR block of the private subnet
variable "private_subnet_cidr_block" {
  description = "Value for the public subnet cidr block"
  type = string
  sensitive = true
}

# Variable for specifying the availability zone for the subnet
variable "availability_zone" {
  description = "Availability zone to be used for hosting the parallel cluster subnets"
  type = string
}
