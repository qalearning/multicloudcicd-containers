output "azure_url" {
  value = azurerm_container_app.containerapp.ingress[0].fqdn
}