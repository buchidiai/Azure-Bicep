
@description('Specifies the name of the environment, e.g. dev, prod')
param environmentName string = 'dev'

param location string = resourceGroup().location

// Set the name of the App Service Plan using the environmentName parameter
var appServicePlanName = 'azbicep-${environmentName}-us-asp1'

// Set the name of the Web App using the environmentName parameter
var webAppName = 'azbicep-${environmentName}-us-wapp1'

// Set the name of the Application Insights instance using the environmentName parameter
var appInsightsName = 'azbicep-${environmentName}-us-wapp1-ai'

// Create an Azure App Service Plan with the name based on the environment name
resource azbicepasp 'Microsoft.Web/serverfarms@2022-03-01' = {

  // Set the name of the App Service Plan
  name: appServicePlanName

  // Set the location of the App Service Plan to be the same as the resource group it belongs to
  location: location

  // Define the SKU of the App Service Plan
  sku: {
    name: 'S1'         // Specify the SKU name as 'S1'
    capacity: 1        // Specify the capacity as 1 instance
  }
}

// Create an Azure Web App with the name based on the environment name
resource azbicepas 'Microsoft.Web/sites@2021-01-15' = {

  // Set the name of the Web App
  name: webAppName

  // Set the location of the Web App to be the same as the resource group it belongs to
  location: location

  // Specify the App Service Plan for the Web App
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', appServicePlanName)
    // Set the serverFarmId property to the resource ID of the App Service Plan created earlier
  }

  // Specify that this resource depends on the appServicePlan resource
  dependsOn:[
    azbicepasp
  ]
}


// Define an Azure Resource Manager template for configuring the app settings of an Azure Web App resource
resource azbicepwebapp1appsetting 'Microsoft.Web/sites/config@2022-03-01' = {
  name: 'web' // Name of the Web App resource
  parent: azbicepas // Parent resource (the Web App resource group)
  properties: {
    appSettings: [ // Array of key-value pairs representing app settings
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY' // Name of the app setting
        value: azbicepappinsights.properties.InstrumentationKey // Value of the app setting
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
}


// Create an Azure Application Insights instance with the name based on the environment name
resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {

  // Set the name of the Application Insights instance
  name: appInsightsName

  // Set the location of the Application Insights instance to be the same as the resource group it belongs to
  location: location

  // Specify the kind of Application Insights instance to be a web app
  kind: 'web'

  // Set the properties of the Application Insights instance
  properties: {
    Application_Type: 'web'
  }
}
