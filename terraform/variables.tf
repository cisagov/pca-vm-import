variable "aws_region" {
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default = "us-east-1"
}

variable "aws_availability_zone" {
  description = "The AWS availability zone to deploy into (e.g. a, b, c, etc.)."
  default = "a"
}

variable "tags" {
  type = "map"
  description = "Tags to apply to all AWS resources created"
  default = {}
}

variable "bucket_name" {
  description = "The name of the bucket where the VM image is temporarily stored during the import process."
  default = "pca-vm-import"
}

variable "role_name" {
  description = "The name of the role used to import the VM image."
  default = "pca-vm-import"
}
