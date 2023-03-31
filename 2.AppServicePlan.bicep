@description('Specifies the location for resources.')
param location string = resourceGroup().location

// Create an Azure App Service Plan with the name 'azbicep-dev-us-asp1'
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {

  // Set the name of the App Service Plan
  name: 'azbicep-dev-us-asp1'

  // Set the location of the App Service Plan to be the same as the resource group it belongs to
  location: location

  // Define the SKU of the App Service Plan
  sku: {
    name: 'S1'         // Specify the SKU name as 'S1'
    capacity: 1        // Specify the capacity as 1 instance
  }
}
