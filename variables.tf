

variable "private_subnets_cidr" {
  type        = list(string)
  default     = ["10.100.3.0/24", "10.100.4.0/24"]
  description = "Private Subnet CIDRs"
}

variable "region" {
  default    =  "us-east-1"
  description = "Region in which the bastion host will be launched"
}

variable "availability_zones" {
  type        = list
  default     = ["us-east-1b", "us-east-1c"]
  description = "AZ in which all the resources will be deployed"
}

# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.100.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment 
variable "env" {
  default     = "prod"
  type        = string
  description = "Deployment Environment"
}
