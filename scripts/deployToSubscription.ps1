$templateFile = '../templates/multi-scoped.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "adora-subscription-scoped-$today"

New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile