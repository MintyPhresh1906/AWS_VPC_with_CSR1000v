# to replace XX with VPC number :%s/XX/number
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-67696e0d" # CSR1000v
    }
}
variable "vpc_NAME" {
	default = "VPC_XXX"
}

variable "CSR1000v_instance_type" {
	default = "m3.medium"
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.XXX.0/24"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.XXX.0/28"
}

variable "G1_static_private_ip" {
    default = "10.0.XXX.5"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.XXX.16/28"
}

variable "G2_static_private_ip" {
    default = "10.0.XXX.20"
}
