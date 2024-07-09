﻿<#
.SYNOPSIS
    Get locked MCS catalog machines. Applicable for Citrix DaaS and on-prem.
.DESCRIPTION
    Gets all the Virtual Machines that were locked
    The original version of this script is compatible with Citrix Virtual Apps and Desktops 7 2203 Long Term Service Release (LTSR).
#>

# /*************************************************************************
# * Copyright © 2024. Cloud Software Group, Inc. All Rights Reserved.
# * This file is subject to the license terms contained
# * in the license file that is distributed with this file.
# *************************************************************************/

# Add Citrix snap-ins
Add-PSSnapin -Name "Citrix.MachineCreation.Admin.V2"

# [User Input Required]
$locked = $true

######################################################################################################
# Gets all locked Virtual Machines, regardless of which Provisioning Scheme the VM was created with. #
######################################################################################################

Get-ProvVM -Locked $locked