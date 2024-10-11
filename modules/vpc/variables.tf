variable "private_subnet_cidr_block" {
  description = "Value for the public subnet cidr block"
  type = string
  sensitive = true
}

variable "availability_zone" {
  description = "Availability zone to be used for hosting the parallel cluser subnets"
  type = string
}