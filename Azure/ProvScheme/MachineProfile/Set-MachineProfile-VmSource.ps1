﻿<#
.SYNOPSIS
    Sets or changes the MachineProfile parameter on an existing MCS catalog.
	The updated machine profile will be applicable to new machines post operation, not to the existing machines.
	For applying to existing machines, run Set-ProvVmUpdateTimeWindow. Applicable for Citrix DaaS and on-prem.
.DESCRIPTION
    Set-MachineProfile-VmSource.ps1 helps change the MachineProfile configuration on an existing MCS catalog.
    In this example, the MachineProfile parameter is updated on the ProvScheme.
    The original version of this script is compatible with Citrix Virtual Apps and Desktops 7 2402 Long Term Service Release (LTSR).
#>

# /*************************************************************************
# * Copyright © 2024. Cloud Software Group, Inc.
# * This file is subject to the license terms contained
# * in the license file that is distributed with this file.
# *************************************************************************/

# Add Citrix snap-ins
Add-PSSnapin -Name "Citrix.Host.Admin.V2","Citrix.MachineCreation.Admin.V2"

# [User Input Required] Set parameters for Set-ProvScheme
$provisioningSchemeName = "demo-provScheme"
$hostingUnitName = "demo-hostingUnit"
$resourceGroupName = "demo-resourceGroup"

# Update the MachineProfile parameter to point to a VM source
$machineProfileVmName = "demo-vmName"
$updatedMachineProfile = "XDHyp:\HostingUnits\$hostingUnitName\machineprofile.folder\$resourceGroupName.resourcegroup\$machineProfileVmName.vm"

# Modify the ProvisioningScheme
Set-ProvScheme -ProvisioningSchemeName $provisioningSchemeName -MachineProfile $updatedMachineProfile

# Schedules all existing VMs to be updated with the new configuration on the next power on
Set-ProvVmUpdateTimeWindow -ProvisioningSchemeName $provisioningSchemeName