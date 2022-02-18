variable "ENVIRONMENT" {}
variable "PROJECT" {}

variable "AMI" {
  default = "ami-04505e74c0741db8d"
}

variable "VPC_CIDR_BLOCK" {
  default = "10.0.0.0/16"
}

variable "SUBNET_CIDR_BLOCK" {
  default = "10.0.1.0/24"
}



