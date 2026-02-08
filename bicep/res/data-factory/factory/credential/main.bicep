@description('Required. The name of the Azure Factory to create.')
param dataFactoryName string

@description('Required. The name of the Credential.')
param name string

@description('Required. The type of the Credential.')
@allowed([
  'ManagedIdentity'
  'ServicePrincipal'
])
param type string

@description('Required. The properties specific to the credential type.')
param typeProperties object

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' existing = {
  name: dataFactoryName
}

resource credential 'Microsoft.DataFactory/factories/credentials@2018-06-01' = {
  name: name
  parent: dataFactory
  properties: {
    type: type
    typeProperties: typeProperties
  }
}

@description('The name of the deployed credential')
output name string = credential.name

@description('The resource ID of the deployed credential')
output resourceId string = credential.id
