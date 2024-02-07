﻿<#
.SYNOPSIS
    Get information about MCS catalog. Applicable for Citrix DaaS and on-prem.
.DESCRIPTION
    Get-ProvSchemeByName.ps1 emulates the behavior of the Get-ProvScheme command.
    It provides information about provisioning schemes, allowing administrators to manage virtual machines.
    The original version of this script is compatible with Citrix Virtual Apps and Desktops 7 2203 Long Term Service Release (LTSR).
#>

# /*************************************************************************
# * Copyright © 2024. Cloud Software Group, Inc.
# * This file is subject to the license terms contained
# * in the license file that is distributed with this file.
# *************************************************************************/

# Add Citrix snap-ins
Add-PSSnapin -Name "Citrix.MachineCreation.Admin.V2"

# [User Input Required]
$provisioningSchemeName = "demo-provScheme"

# Get information about a specific Provisioning Scheme
# It returns an empty result if a catalog is a non-MCS provisioned catalog. You can run Get-BrokerCatalog to get more information
Get-ProvScheme -ProvisioningSchemeName $provisioningSchemeName