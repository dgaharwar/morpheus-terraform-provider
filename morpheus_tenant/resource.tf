data "morpheus_tenant_role" "example" {
  name = "Tenant Admin"
}

resource "morpheus_tenant" "tf_example_tenant" {
  name            = var.tenant_name
  description     = var.tenant_description
  enabled         = true
  subdomain       = "tfexample"
  base_role_id    = data.morpheus_tenant_role.example.id
  currency        = var.tenant_currency
  account_number  = "12345"
  account_name    = "tenant 12345"
  customer_number = "12345"
}
