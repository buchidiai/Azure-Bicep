resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-dev-us-asp1'
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
  }
}
