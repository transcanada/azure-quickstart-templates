configuration InitializeServer 
{ 
   param 
    ( 
        [Parameter(Mandatory)]
        [String]$DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Admincreds,

        [Int]$RetryCount = 20,
        [Int]$RetryIntervalSec = 30
    ) 
    
    Import-DscResource -ModuleName xActiveDirectory, xComputerManagement, xDisk, cDisk

    [System.Management.Automation.PSCredential]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
   
    Node localhost
    {
        WindowsFeature ADPowershell
        {
            Name = "RSAT-AD-PowerShell"
            Ensure = "Present"
        } 

        xWaitForADDomain WaitForDomain 
        { 
            DomainName = $DomainName 
            DomainUserCredential= $Admincreds
            RetryCount = $RetryCount 
            RetryIntervalSec = $RetryIntervalSec
            DependsOn = "[WindowsFeature]ADPowershell" 
        }
        xComputer DomainJoin
        {
            Name = $env:COMPUTERNAME
            DomainName = $DomainName
            Credential = $DomainCreds
            DependsOn = "[xWaitForADDomain]WaitForDomain" 
        }
        xWaitforDisk Disk2
        {
             DiskNumber = 2
             RetryIntervalSec =$RetryIntervalSec
             RetryCount = $RetryCount
        }
        cDiskNoRestart ADDataDisk
        {
            DiskNumber = 2
            DriveLetter = "F"
        }        
   }
} 
