<#
.SYNOPSIS
    Moves recommended RPs for a given IaasVM
.DESCRIPTION
    Moves recommended RPs for a given IaasVM.
    This requires PowerShell 7.0 and Az.RecoveryServices preview module installed 
#>

param( 
    [Parameter(Mandatory=$true, HelpMessage="SubscriptionId or SubscriptionName ")] 
    [string] $Subscription, 

    [Parameter(Mandatory=$true)] 
    [string] $ResourceGroupName,

    [Parameter(Mandatory=$true)] 
    [string] $VaultName,
    
    [Parameter(Mandatory=$true, HelpMessage="Name of Backup Item")] 
    [string] $BackupItemName
)

function script:TraceMessage([string] $message, [string] $color="Yellow")
{
    Write-Host "`n$message" -ForegroundColor $color
}

try
{
    Set-AzContext -Subscription $Subscription | Out-Null
}
catch
{
    Add-AzAccount
    Set-AzContext -Subscription $Subscription | Out-Null
}

#fetch recovery services vault  
$vault =  Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $VaultName

# fetch vm backup items
$vmItems = Get-AzRecoveryServicesBackupItem -BackupManagementType "AzureVM" `
    -WorkloadType "AzureVM" -VaultId $vault.ID | Where-Object { $_.Name -eq $BackupItemName}

$result = @()    
# for each vm item - move all recommended RPs to Archive
foreach ($vmItem in $vmItems){
    $recRPList = Get-AzRecoveryServicesBackupRecommendedArchivableRPGroup -Item $vmItem -VaultId $vault.ID

    foreach ($rp in $recRPList){
        $job = Move-AzRecoveryServicesBackupRecoveryPoint -RecoveryPoint $rp `
        -SourceTier $rp.RecoveryPointTier -DestinationTier VaultArchive -VaultId $vault.ID

        $result = $result + $job
    }
}

Write-Output($result)