﻿<#
.SYNOPSIS
    Remove a provisioning Scheme. Applicable for Citrix DaaS and on-prem.
.DESCRIPTION
    Remove-ProvVm-ForgetVm.ps1 only removes VM object from the Machine Creation Services database;
	however, VM's related resources (network interface, OsDisk etc.) remained in the hypervisor
	after its tags/identifiers created by provisioning process and associated with the provisioning scheme will be removed
    The original version of this script is compatible with Citrix Virtual Apps and Desktops 7 2203 Long Term Service Release (LTSR).
#>

# /*************************************************************************
# * Copyright © 2024. Cloud Software Group, Inc.
# * This file is subject to the license terms contained
# * in the license file that is distributed with this file.
# *************************************************************************/

# Add Citrix snap-ins
Add-PSSnapin -Name "Citrix.Host.Admin.V2","Citrix.MachineCreation.Admin.V2","Citrix.Broker.Admin.V2","Citrix.ADIdentity.Admin.V2"

# [User Input Required]
$provisioningSchemeName = "demo-provScheme"
$vmName = "demo-vm"
$identityPoolName = "demo-identityPoolName"
$machineName = "DOMAIN\demo-vm"

###################################
# Step 1: Get ProvVM ID to remove #
###################################

$vmIDToRemove = Get-ProvVM -ProvisioningSchemeName $provisioningSchemeName -VMName $vmName | Select-Object VMId

#############################
# Step 2: Unlock the ProvVM #
#############################

Unlock-ProvVM -ProvisioningSchemeName $provisioningSchemeName -VMID $vmIDToRemove

# ForgetVM option can only be applied to persistent VMs
# ForgetVM option cannot be used with PurgeDBOnly.
#############################
# Step 3: Forget the ProvVM #
#############################

Remove-BrokerMachine -MachineName $machineName
Remove-ProvVM -ProvisioningSchemeName $provisioningSchemeName -VMName $vmName -ForgetVM
Remove-AcctADAccount -IdentityPoolName $identityPoolName -ADAccountName $machineName -RemovalOption "None"