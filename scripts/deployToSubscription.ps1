$templateFile = '../src/multi-scoped.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "adora-subscription-scoped-$today"
$resourceGroupName = "testrg"

New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile