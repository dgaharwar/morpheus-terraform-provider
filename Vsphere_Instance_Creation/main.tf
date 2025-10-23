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

data "morpheus_group" "morpheus_lab" {
  name = "All Clouds"
}

data "morpheus_cloud" "morpheus_vsphere" {
  name = "Demo"
}

data "morpheus_resource_pool" "vsphere_resource_pool" {
  name     = "Demo"
  cloud_id = data.morpheus_cloud.morpheus_vsphere.id
}

data "morpheus_cloud_folder" "vsphere_folder" {
  name     = "dg-test-demo"
  cloud_id = data.morpheus_cloud.morpheus_vsphere.id
}

data "morpheus_instance_type" "ubuntu" {
  name = "Ubuntu"
}

data "morpheus_instance_layout" "ubuntu" {
  name    = "VMware VM"
  version = "22.04"
}

data "morpheus_network" "vmnetwork" {
  name = "VLAN0002 - Internal Server 2"
}

data "morpheus_plan" "vmware" {
  name           = "1 CPU, 4GB Memory"
  provision_type = "vmware"
}

resource "morpheus_vsphere_instance" "tf_example_vsphere_instance" {
  name               = var.instance_name
  description        = "Terraform instance example"
  cloud_id           = data.morpheus_cloud.morpheus_vsphere.id
  group_id           = data.morpheus_group.morpheus_lab.id
  instance_type_id   = data.morpheus_instance_type.ubuntu.id
  instance_layout_id = data.morpheus_instance_layout.ubuntu.id
  plan_id            = data.morpheus_plan.vmware.id
  environment        = "dev"
  resource_pool_id   = data.morpheus_resource_pool.vsphere_resource_pool.id
  folder_id          = data.morpheus_cloud_folder.vsphere_folder.id
  labels             = ["demo", "terraform"]

  interfaces {
    network_id = data.morpheus_network.vmnetwork.id
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
