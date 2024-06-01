@description('The Azure region into which the resources should be deployed.')
param location string

@description('The name of the traffic manager.')
param trafficManagerName string

@description('The traffic manager DNS TTL in seconds.')
param trafficManagerTtl int

@description('The traffic manager monitor interval in seconds.')
param trafficManagerMonitorInterval int

@description('The traffic manager monitor interval address.')
param trafficManagerMonitorTimeout int

@description('The number of failed health checks the traffic manager tolerates before degrading an endpoint')
param trafficManagerMonitorToleratedNumberOfFailures int

@description('The traffic manager target IP address.')
param trafficManagerTargetIp string

param status string = 'Enabled'

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: trafficManagerName
  location: 'global'
  properties: {
    profileStatus: status
    trafficRoutingMethod: 'Priority'
    dnsConfig: {
      relativeName: trafficManagerName
      ttl: trafficManagerTtl
    }
    monitorConfig: {
      protocol: 'HTTP'
      port: 80
      path: '/'
      intervalInSeconds: trafficManagerMonitorInterval
      timeoutInSeconds: trafficManagerMonitorTimeout
      toleratedNumberOfFailures: trafficManagerMonitorToleratedNumberOfFailures
    }
    endpoints: [
      {
        name: 'Azure-Endpoint' 
        type: 'Microsoft.Network/TrafficManagerProfiles/ExternalEndpoints'
        properties: {
          target: trafficManagerTargetIp
          endpointStatus: status
          endpointLocation: location
          priority: 1
        }
      }  
    ]
  }
}
