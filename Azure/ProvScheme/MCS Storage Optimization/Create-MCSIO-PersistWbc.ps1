﻿<#
.SYNOPSIS
    Creates an MCS catalog with a write cache style disk for each VM.
.DESCRIPTION
    Create-MCSIO-PersistWbc.ps1 creates an MCS Provisioning Scheme with Write-back cache enabled and enables persisting the write-back cache disk between power cycles.
    The original version of this script is compatible with Citrix Virtual Apps and Desktops 7 2402 Long Term Service Release (LTSR).
    Note: if WriteBackCacheDriveLetter is not used, this script will be compatible with Citrix Virtual Apps and Desktops 7 2203 Long Term Service Release (LTSR).
#>

# /*************************************************************************
# * Copyright © 2024. Cloud Software Group, Inc. All Rights Reserved.
# * This file is subject to the license terms contained
# * in the license file that is distributed with this file.
# *************************************************************************/

# Add Citrix snap-ins
Add-PSSnapin -Name "Citrix.Host.Admin.V2","Citrix.MachineCreation.Admin.V2"

#------------------------------------------------- Create a ProvisioningScheme -----------------------------------------------------#
# [User Input Required] Set parameters for New-ProvScheme
$isCleanOnBoot = $true
$provisioningSchemeName = "demo-provScheme"
$identityPoolName = $provisioningSchemeName
$hostingUnitName = "demo-hostingUnit"
$masterImageResourceGroupName = "demo-resourceGroup"
$masterImage = "demo-snapshot.snapshot"
$vNet = "MyVnet"
$subnet = "subnet1"
$machineProfile = "demo-machineProfile.vm"
$masterImagePath = "XDHyp:\HostingUnits\$hostingUnitName\image.folder\$masterImageResourceGroupName.resourcegroup\$masterImage"
$networkMapping = @{"0"="XDHyp:\HostingUnits\$hostingUnitName\East US.region\virtualprivatecloud.folder\$masterImageResourceGroupName.resourcegroup\$vNet.virtualprivatecloud\$subnet.network"}
$machineProfilePath = "XDHyp:\HostingUnits\$hostingUnitName\machineprofile.folder\$masterImageResourceGroupName.resourcegroup\$machineProfile"
$numberOfVms = 1

# Set the PersistWbc custom property.
# Persist the write back cache disk for the non-persistent provisioned virtual machine between power cycles. Specify either True or False.
# If this property is not specified, the write back cache disk is deleted when the virtual machine is shut down, and is re-created when the virtual machine is powered on.
$customProperties = @"
<CustomProperties xmlns="http://schemas.citrix.com/2014/xd/machinecreation" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<Property xsi:type="StringProperty" Name="PersistWbc" Value="true"/>
</CustomProperties>
"@

# Create the ProvisioningScheme with WriteBackCache
# WriteBackCache has 4 parameters:
# UseWriteBackCache indicates whether to use WriteBackCache
# WriteBackCacheDiskSize is a required parameter to use if using UseWriteBackCache
# Optional. WriteBackCacheMemorySize is the size in MB of any write-back cache if required. Should be used in conjunction with WriteBackCacheDiskSize.
# Optional. WriteBackCacheDriveLetter is a customized drive letter of write-back cache disk which can be any character between ‘E’ and ‘Z’. If not specified, the drive letter is auto assigned by operating system
New-ProvScheme -CleanOnBoot:$isCleanOnBoot `
-ProvisioningSchemeName $provisioningSchemeName `
-HostingUnitName $hostingUnitName `
-IdentityPoolName $identityPoolName `
-InitialBatchSizeHint $numberOfVms `
-MasterImageVM $masterImagePath `
-NetworkMapping $networkMapping `
-CustomProperties $customProperties `
-MachineProfile $machineProfilePath `
-UseWriteBackCache -WriteBackCacheDiskSize 127 -WriteBackCacheMemorySize 256 -WriteBackCacheDriveLetter E