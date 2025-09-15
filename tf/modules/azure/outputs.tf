output "azure_url" {
  value = "http://${azurerm_container_app.containerapp.ingress[0].fqdn}"
}