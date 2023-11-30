variable "gcp_project" {
  type = string
  default = ""
}

variable "gcp_region" {
  type = string
  default = "us-central1"
}

variable "gcp_zone" {
  type = string
  default = "us-central1-a"
}

variable "instance_zone01" {
  type = string
  default = "us-central1-a"
}

variable "instance_zone02" {
  type = string
  default = "us-central1-b"
}

variable "instance_zone03" {
  type = string
  default = "us-central1-c"
}

# variable "instance_name" {
#   type = string
#   default = "ubuntu-node"
# }

variable "instance_type" {
  type = string
  default = "e2-standard-2"
}

variable "image" {
  type = string
  default = "ubuntu-2004-focal-v20230907"
}
