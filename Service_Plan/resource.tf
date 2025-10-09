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

variable "prefix" {
  description = "The prefix that will be applied to the plan name"
  type        = string
  default     = "tf-example"
}

data "morpheus_price_set" "tf_example_service_plan"{
  name = "Default Price Set"
}

resource "morpheus_service_plan" "tf_example_service_plan" {
  for_each = { for row in csvdecode(file("${path.module}/_plans.csv")) : row.name => row }
  name = "${var.prefix}${each.value.name}"
  code = lower(trimsuffix(replace("${var.prefix}${each.value.name}", "/[\\W]+/", "-"), "-"))
  display_order = each.value.display_order
  provision_type = each.value.provision_type
  max_cores = each.value.core_nb
  custom_cores = false
  max_memory = each.value.memory_gb * 1024 * 1024 * 1024
  memory_size_type = "mb"
  custom_memory = false
  max_storage = each.value.disk_gb * 1024 * 1024 * 1024
  storage_size_type = "gb"
  customize_root_volume = false
  customize_extra_volumes = true
  add_volumes = true
  max_disks_allowed = 0
  price_set_ids = [data.morpheus_price_set.tf_example_service_plan.id]
}
