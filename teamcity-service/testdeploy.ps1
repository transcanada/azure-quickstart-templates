
$testNum=57
$testName="dotest$($testNum)"
	
$location = 'West US'
New-AzureResourceGroup -Name $testName -DeploymentName "$($testName)deploy" -Location $location `
	-TemplateFile azuredeploy.json -TemplateParameterFile azuredeploy.parameters.json `
	-newStorageAccountName "$($testName)storage" `
	-virtualNetworkName "$($testName)vnt" `
	-adVMName "$($testName)advm" `
	-domainName "$($testName).com" `
	-addnsName "$($testName)-ad" `
	-locationFromTemplate $location `
	-DatabaseServerName "$testName" `
	-DatabaseName "$($testName)DB" `
	-TeamCityDNSNameForPublicIP "$($testName)-tcs" `
	-Verbose
		