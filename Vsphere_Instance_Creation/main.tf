terraform {
  required_providers {
    morpheus = {
      source  = "gomorpheus/morpheus"
      version = "0.14.0"
    }
  }
}

provider "morpheus" {
  url          = var.morpheus_url
  access_token = var.morpheus_access_token
}

variable "morpheus_url" {
  description = "The URL of the Moprheus platform"
  type        = string
}

variable "morpheus_access_token" {
  description = "The bearer token of the user account used to access the Morpheus platform"
  type        = string
}

variable "instance_name" {
  description = "The name of the instance to create"
  type        = string
  default     = "tfvsphere"
}

resource "morpheus_vsphere_instance" "tf_example_vsphere_instance" {
  name               = var.instance_name
  description        = "Terraform instance example"
  cloud_id           = 1
  group_id           = 26
  instance_type_id   = 9
  instance_layout_id = 1236
  plan_id            = 374
  environment        = "dev"
  resource_pool_id   = 857
  folder_id          = 624
  labels             = ["demo", "terraform"]

  interfaces {
    network_id = 2937
  }

  tags = {
    name = "ubuntutf"
  }

  evar {
    name   = "application"
    value  = "demo"
    export = true
    masked = true
  }

  custom_options = {
    vsphereDatacenter = "denver"
  }
}