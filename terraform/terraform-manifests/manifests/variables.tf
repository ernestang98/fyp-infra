terraform {
  backend "s3" {
    bucket         = "$REMOTE_BUCKET"
    key            = "global/s3/terraform.tfstate"
    region         = "$REGION"
    dynamodb_table = "$REMOTE_DB"
    encrypt        = true
  }
}

variable "REGION" {
  type    = string
  default = "$REGION"
}

variable "ACCESS_KEY" {
  type    = string
  default = "$ACCESS_KEY"
}

variable "SECRET_KEY" {
  type    = string
  default = "$SECRET_KEY"
}

variable "ami" {
  type    = string
  default = "ami-02ee763250491e04a"
}

variable "instance_type" {
  type    = string
  default = "t2.medium"
}

variable "key_name" {
  type    = string
  default = "fyp-sshKey"
}

variable "volume_size" {
  type    = number
  default = 20
}

variable "subnet_prefix" {
  type = list(any)
  default = [
    { "cidr_block" = "10.0.1.0/24", "name" = "fyp-subnet-1", "az" = "ap-southeast-2a" },
    { "cidr_block" = "10.0.2.0/24", "name" = "fyp-subnet-2", "az" = "ap-southeast-2b" },
    { "cidr_block" = "10.0.3.0/24", "name" = "fyp-subnet-3", "az" = "ap-southeast-2c" }
  ]
}
