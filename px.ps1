# DESCRIPTION : Powertools shorthand
# TAGS : powertools

param (
    [string]$Action,
    [string]$Param1
)

# Si aucun param�tre n'est fourni, d�finir Action �"help"
if (-not $Action) {
    $Action = "help"
}

# Obtient le chemin du dossier o� le script est situ�
$scriptPath = $PSScriptRoot
$powertoolsPath = Join-Path -Path $scriptPath -ChildPath "powertools.ps1"

# Appelle powertools.ps1 avec les m�mes param�tres
& $powertoolsPath -Action $Action -Param1 $Param1
