variable "ami" { }
variable "instance_type" { }
variable "subnet_id" { }
variable "key_name" { }
variable "vpc_security_group_ids {
    type = list(string)
}
variable "user_data" {
    type = string
}
variable "instance_name" {
    type = string
}
