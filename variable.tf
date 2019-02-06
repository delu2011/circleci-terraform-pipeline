variable "environment" {
  type    = "string"
  default = "test"
}

#variable "s3_region" {
#  type = "string"
#}

variable "availability_zones" {
  type = "list"
}

variable "bastion_instance_type" {
  type = "string"
}

variable "cidr_block" {
  type = "string"
}

variable "AWS_REGION" {
  type = "string"
}
