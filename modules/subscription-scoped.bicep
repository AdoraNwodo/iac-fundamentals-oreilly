targetScope = 'subscription'

@description('Specifies the location for the resource group.')
param location string

@description('Specifies the name of the resource group.')
param name string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: name
  location: location
}

@description('The name of the resource group.')
output resourceGroupName string = resourceGroup.name
