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

## Step1
Create an Automation resource with “Run As” account

## Step2
Import modules from Gallery in the Automation resource

Import the following modules from the Modules gallery:
1. Az.RecoveryServices 4.0.0-preview 

## Step3
Create PowerShell Runbooks in the Automation Resource. You can create multiple Runbooks based on which set of RPs you want to move

## Step4
Edit the Runbook and write script to choose BackupItem for archive move. You can create scripts that suit your requirements.
- Save the script
- Test the script using “Test Pane”
- Publish the Runbook

Scripts for different usages are provided in the repository

## Step5
Schedule the Runbook. While scheduling the Runbook, you can pass on the parameters required for the PowerShell Script. You can use '-?' to see the needed parameters for each script.
