// Set the deployment scope to the entire subscription
targetScope = 'subscription'

// Create a new Azure Resource Group with the name azbicep-dev-us-rg and location eastus
resource azbicepresourcegroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'azbicep-dev-us-rg'
  location: 'eastus'
}
