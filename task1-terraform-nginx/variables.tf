variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "key_name" {
  description = "The name of the AWS key pair to use for SSH access"
  type        = string

}
variable "public_key_path" {
  description = "Path toSSH public key"

}
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC to launch the instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The security group to associate with the EC2 instance"
  type        = list(any)

}
variable "subnet_id" {
    description = "The subnet ID to launch the instance"
    type        = string
  
}