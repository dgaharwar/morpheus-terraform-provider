variable "morpheus_url" {
  description = "The URL of the Moprheus platform"
  type        = string
}

variable "morpheus_username" {
  description = "The username of the user account used to access the Morpheus platform"
  type        = string
}

variable "morpheus_password" {
  description = "The password of the user account used to access the Morpheus platform"
  type        = string
}

variable "tenant_name" {
  description = "The name of the tenant being created on Morpheus platform"
  type        = string
}

variable "tenant_description" {
  description = "The description of the tenant being created on Morpheus platform"
  type        = string
}

variable "tenant_currency" {
  description = "The currency of the tenant being created on Morpheus platform"
  type        = string
}
