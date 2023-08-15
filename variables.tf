variable "domain_name" {
  type = string
  description = "Name of the domain"
  default = "sambordo.ninja"
}

variable "bucket_name" {
  type = string
  description = "Name of the bucket."
  default = "sambordo.ninja"
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