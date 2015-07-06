
$instanceNum=1
$testName="tmcty$($instanceNum)"
	
$location = 'West US'
New-AzureResourceGroup -Name $testName -DeploymentName "$($testName)deploy" -Location $location `
	-TemplateFile azuredeploy.json `
	-newStorageAccountName "$($testName)storage" `
	-virtualNetworkName "$($testName)vnt" `
	-locationFromTemplate $location `
	-DatabaseServerName "$testName" `
	-DatabaseName "$($testName)DB" `
	-TeamCityDNSNameForPublicIP "$($testName)-tcs" `
	-Verbose
