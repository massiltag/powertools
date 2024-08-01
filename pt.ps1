# DESCRIPTION : Powertools shorthand
# TAGS : powertools

param (
    [string]$Action,
    [string]$Param1
)

# Obtient le chemin du dossier où le script est situé
$scriptPath = $PSScriptRoot
$powertoolsPath = Join-Path -Path $scriptPath -ChildPath "powertools.ps1"

# Appelle powertools.ps1 avec les mêmes paramètres
& $powertoolsPath -Action $Action -Param1 $Param1
