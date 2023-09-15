variable "domain_name" {
  type = string
  description = "Name of the domain"
  default = "sambordo.ninja"
}
variable "bucket_name" {
  type = string
  description = "Name of the website bucket."
  default = "sambordo.ninja"
}
variable "backup_bucket_name" {
  type = string
  description = "Name of the backup bucket."
  default = "sambordo.ninja.terraform.backup"
}
variable "region" {
    type = string
    default = "us-east-1"
}
variable "hosted_zone_ID" {
    type = string
    default = "Z04443182XGT3L5K43LEJ"
}
variable "origin_domain" {
    type = string
    default = "sambordo.ninja.s3-website-us-east-1.amazonaws.com"
}
variable "ec2_ami" {
    type = string
    default = "ami-053b0d53c279acc90"
}
variable "ec2_instance_type" {
    type = string
    default = "t2.micro"
}
variable "key_name" {
    type = string
    default = "ninja-ec2"
}
variable "subnet_id1" {
    type = string
    default = "subnet-015f2c5c6d2399c34"
}
variable "subnet_id2" {
    type = string
    default = "subnet-0659f4fde313fea16"
}
variable "subnet_id3" {
    type = string
    default = "subnet-0f6e496d8bc75dc4d"
}
variable "vpc_id" {
    type = string
    default = "vpc-0111c0f25045d6b0f"
}