---
page_type: sample
languages:
- powershell
products:
- azure
description: "Automates top asks using PowerShell for Azure Backup archive feature"
---

# Automate top asks using PowerShell for Azure Backup

Automate archive move using [PowerShell for Azure Backup](https://docs.microsoft.com/en-us/azure/backup/archive-tier-support)

## Features
Runbooks for Archive move

## Sample Scripts 

1. Run Latest Version of Powershell in administrator mode 
2. Run the following command to set the execution policy

     a. Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process 
3. Download and Run the sample scripts. 
 
## View Archivable Points 

### Location

Download [viewArchivableRPs](https://github.com/hiaga/Az.RecoveryServices/tree/master/ArchiveFeatureSupport)

### Purpose 

This sample script is used to view all the archivable recovery points associated with a backup item between any time range. 

### Input Parameters  

1. Subscription 
2. ResourceGroupName 
3. VaultName 
4. ItemType – {AzureVM,MSSQL) 
5. StartDate = (Get-Date).AddDays(-x).ToUniversalTime()  
6. EndDate = (Get-Date).AddDays(-y).ToUniversalTime() 
7. BackupItem  

Where x and y are the time-range between which you want to move the recovery points. 

#### The $BackupItem can be found out using 
1. For Azure Virtual Machines 

    $BackupItemList = Get-AzRecoveryServicesBackupItem -vaultId $vault.ID -BackupManagementType "AzureVM" -WorkloadType "AzureVM" 

2. For SQL Server in Azure Virtual Machines 

    $BackupItemList = Get-AzRecoveryServicesBackupItem -vaultId $vault.ID -BackupManagementType "AzureWorkload" -WorkloadType "MSSQL" 

### Output 

A list of archivable recovery point 
 

### Example Usage 

$ArchivableRecoveryPoints = .\viewArchivableRPs.ps1 -Subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -ResourceGroupName "ResourceGroupName" -VaultName "VaultName" -ItemType "MSSQL/AzureVM" -BackupItem $BackupItemList[2] -StartDate (Get-Date).AddDays(-165).ToUniversalTime() -EndDate (Get-date).AddDays(0).ToUniversalTime() 

 

## Move all Archivable recovery point for a SQL Server in Azure VM 

### Location 
Download [moveArchivableRecoveryPointsForSQL](https://github.com/hiaga/Az.RecoveryServices/tree/master/ArchiveFeatureSupport)

### Purpose

This sample script moves all the archivable recovery point for a particular SQL Backup Item to archive. 
 

### Input Parameters 

1. Subscription 
2. ResourceGroupName 
3. VaultName 
4. BackupItem
5. StartDate (Get-Date).AddDays(-x).ToUniversalTime() 
6. EndDate (Get-date).AddDays(-y).ToUniversalTime() 

Where x and y are the time-range between which you want to move the recovery points. 

#### The $BackupItem can be found out using 

1. For SQL Server in Azure Virtual Machines 

    $BackupItemList = Get-AzRecoveryServicesBackupItem -vaultId $vault.ID -BackupManagementType "AzureWorkload" -WorkloadType "MSSQL" 

 
### Output 

A list of move jobs initiated for each recovery point being moved to archive. 
 

### Example Usage 

$MoveJobsSQL = .\moveArchivableRecoveryPointsForSQL.ps1 -Subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -ResourceGroupName "ResourceGroupName" -VaultName "VaultName" -BackupItem $BackupItemList[2] -StartDate (Get-Date).AddDays(-165).ToUniversalTime() -EndDate (Get-date).AddDays(0).ToUniversalTime() 

 

## Move all recommended recovery points to archive for a Virtual Machine workload 

### Location 

Download [moveRecommendedRPsForIaasVM](https://github.com/hiaga/Az.RecoveryServices/tree/master/ArchiveFeatureSupport)


### Purpose

Move all the recommended recovery points to archive for a particular Virtual Machine workload. 

### Input Parameters 

1. Subscription 
2. ResourceGroupName 
3. VaultName 
4. BackupItem

 
#### The BackupItem can be found out from the list 

1. For Azure Virtual Machines 

    $BackupItemList = Get-AzRecoveryServicesBackupItem -vaultId $vault.ID -BackupManagementType "AzureVM" -WorkloadType "AzureVM" 

### Output 

A list of move jobs initiated for each recovery point being moved to archive 

### Example Usage 

$MoveJobsIaasVM = .\moveRecommendedRPsForIaasVM.ps1 -Subscription xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx -ResourceGroupName "ResourceGroupName" -VaultName "VaultName" -BackupItem $BackupItemList[2] 
