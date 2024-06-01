// Imported parameters
@description('Specifies the location for resources.')
param location string

@description('Specifies the CosmosDb account name')
param cosmosDbBaseName string

@description('Specifies the list of cosmosdb containers')
param containers array

// Local parameters
param cosmosDbAccountName string = '${cosmosDbBaseName}-account'
param databaseId string = '${cosmosDbBaseName}-db'
param databaseAccountOfferType string = 'Standard'
param enableAutomaticFailover bool = false
param enableMultipleWriteLocations bool = false
param defaultConsistencyLevel string = 'Session'
param failoverPriority int = 0
param isZoneRedundant bool = false


// Deployments - Cosmos DB Resources
// 1. Cosmos DB Account
resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2021-04-15' = {
  name: cosmosDbAccountName
  location: location
  properties: {
    databaseAccountOfferType: databaseAccountOfferType
    enableAutomaticFailover: enableAutomaticFailover
    enableMultipleWriteLocations: enableMultipleWriteLocations
    consistencyPolicy: {
      defaultConsistencyLevel: defaultConsistencyLevel
    }
    locations: [
      {
        locationName: location
        failoverPriority: failoverPriority
        isZoneRedundant: isZoneRedundant
      }
    ]
  }
}

// 2. Database
resource cosmosDb 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-06-15' = {
  name: '${cosmosDbAccount.name}/${databaseId}'
  dependsOn: [
    cosmosDbAccount
  ]
  properties:{
    resource:{
      id: databaseId
    }
  }
}

// 3. Cosmos DB containers
resource cosmosDbContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2021-06-15' = [for container in containers: {
  name:'${cosmosDb.name}/${container.id}'
  dependsOn: [
    cosmosDbAccount
    cosmosDb
  ]
  properties:{
    resource:{
      id: container.id
      partitionKey:{
        paths:[
          container.partitionKey
        ]
      }
    }
  }
}]
