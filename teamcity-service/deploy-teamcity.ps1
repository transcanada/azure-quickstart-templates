
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
	-TeamCityDNSNameForPublicIP "transcanada-teamcity-$instanceNum" `
	-TeamCityAgentDNSNameForPublicIP "transcanada-teamcity-$($instanceNum)-agent1" `
	-Verbose
