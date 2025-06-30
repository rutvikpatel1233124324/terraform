variable "ec2_instance_type" {
  description = "Type of AWS instance to create"
  type        = string
  default     = "t2.micro" 
}

variable "ec2_root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 8
}

variable "ec2_ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0d1b5a8c13042c939" # Ubuntu 20.04 LTS 
}