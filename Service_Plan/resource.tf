terraform {
  required_providers {
    morpheus = {
      source  = "gomorpheus/morpheus"
      version = "0.12.0"
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
  description = "The access token of the user account used to access the Morpheus platform"
  type        = string
}

data "morpheus_price_set" "tf_example_price_set"{
  name = "Default Price Set"
}

resource "morpheus_service_plan" "tf_example_service_plan" {
  name = "tf-example-sp"
  code = "tf-example-sp1"
  display_order = 0
  provision_type = "vmware"
  max_cores = 1
  custom_cores = false
  max_memory = 1 * 1024 * 1024 * 1024
  memory_size_type = "mb"
  custom_memory = false
  max_storage = 10 * 1024 * 1024 * 1024
  storage_size_type = "gb"
  customize_root_volume = false
  customize_extra_volumes = true
  add_volumes = true
  max_disks_allowed = 0
  price_set_ids = [data.morpheus_price_set.tf_example_price_set.id]
}
