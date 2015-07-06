
$instanceNum=5
$teamCityServiceName="tmcty$($instanceNum)"
	
$location = 'West US'
New-AzureResourceGroup -Name $teamCityServiceName -DeploymentName "$($teamCityServiceName)deploy" -Location $location `
	-TemplateFile azuredeploy.json `
	-newStorageAccountName "$($teamCityServiceName)storage" `
	-virtualNetworkName "$($teamCityServiceName)vnt" `
	-locationFromTemplate $location `
	-DatabaseServerName "$teamCityServiceName" `
	-DatabaseName "$($teamCityServiceName)DB" `
	-TeamCityDNSNameForPublicIP $teamCityServiceName `
	-TeamCityAgentDNSNameForPublicIP "$($teamCityServiceName)-agent1" `
	-Verbose
