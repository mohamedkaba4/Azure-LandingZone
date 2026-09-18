output "management_subscription_id" {
  value = azurerm_subscription.management.subscription_id
}

output "connectivity_subscription_id" {
  value = azurerm_subscription.connectivity.subscription_id
}

output "security_subscription_id" {
  value = azurerm_subscription.security.subscription_id
}
