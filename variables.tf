variable "aws_region" {
  description = "Region to place all AWS resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_name" {
  description = "Name of EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type/size"
  type        = string
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "Name of ssh key pair to assign to EC2 instance. Must already exist in AWS."
  type        = string
  default     = ""
}

variable "ssh_key_local_path" {
  description = "Path to local ssh key"
  type        = string
  default     = ""
}
