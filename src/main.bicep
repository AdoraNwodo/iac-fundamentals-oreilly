param location string = 'eastus'
param resourceBaseName string = 'oreilly-bicep'
param storageAccountName string = 'oreillybcpstr'

module webApp '../modules/webApp.bicep' = {
  name: 'app-service'
  params: {
    appServiceAppName: '${resourceBaseName}-app'
    appServicePlanName: '${resourceBaseName}-plan'
    appServicePlanSkuName: 'S1'
    identityType: 'SystemAssigned'
    minTlsVersion: '1.2'
    location: location
    storageAccountKind: 'StorageV2'
    storageAccountName: storageAccountName
    storageAccountSkuName: 'Standard_LRS'
  }
}

module networking '../modules/networking.bicep' = {
  name: 'networking'
  params: {
    location: location
    trafficManagerMonitorInterval: 30
    trafficManagerMonitorTimeout: 5
    trafficManagerMonitorToleratedNumberOfFailures: 3
    trafficManagerName: '${resourceBaseName}-tm'
    trafficManagerTargetIp: '9.9.9.9'
    trafficManagerTtl: 30
  }
}

module database '../modules/database.bicep' = {
  name: 'cosmosdb'
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
