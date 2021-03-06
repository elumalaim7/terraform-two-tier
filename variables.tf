variable "aws_access_key" {
    default = ""
}
variable "aws_secret_key" {
    default = ""
}
variable "aws_region" {
    default = "ap-southeast-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    default = "10.0.1.0/24"
}

variable "allow_all" {
    default = "0.0.0.0/0"
}

variable "aws_key_name" {
    default = "Devops"
}

variable "private_key_path" {
    default = "~/.ssh/Devops.pem"
}

variable "host" {
    default = ""
}
