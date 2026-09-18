locals {
  billing_scope_id = "/providers/Microsoft.Billing/billingAccounts/2f7e2386-6522-56b9-61ea-4da87413252e:f0952786-98e5-44d3-ba90-074b402deef3_2019-05-31/billingProfiles/IMI2-5Q6H-BG7-PGB/invoiceSections/b038e9aa-08ca-4fbf-827c-924fd073fcf8"
}

resource "azurerm_subscription" "management" {
  alias             = "mavencrest-management"
  subscription_name = "sub-mavencrest-management"
  billing_scope_id  = local.billing_scope_id
  workload          = "Production"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subscription" "connectivity" {
  alias             = "mavencrest-connectivity"
  subscription_name = "sub-mavencrest-connectivity"
  subscription_id   = "237bd9d5-9158-404b-b798-ebd269d6f9ab"
  workload          = "Production"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subscription" "security" {
  alias             = "mavencrest-security"
  subscription_name = "sub-mavencrest-security"
  billing_scope_id  = local.billing_scope_id
  workload          = "Production"

  lifecycle {
    prevent_destroy = true
  }
}
