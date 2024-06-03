param location string = 'eastus'
param resourceBaseName string = 'ada-bicep'

targetScope = 'subscription'

module rg '../modules/subscription-scoped.bicep' = {
  name: '${resourceBaseName}-rg'
  params: {
    name: '${resourceBaseName}-rg'
    location: location
  }
}

module database '../modules/database.bicep' = {
  name: 'cosmosdb'
  scope: resourceGroup(rg.name)
  params: {
    containers: [
      {
        id: 'users'
        partitionKey: '/id'
      }
      {
        id: 'purchases'
        partitionKey: '/id'
      }
    ]
    cosmosDbBaseName: resourceBaseName
    location: location
  }
}
