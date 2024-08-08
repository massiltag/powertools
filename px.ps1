# DESCRIPTION : Powertools shorthand
# TAGS : powertools

param (
    [string]$Action,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Si aucun paramètre n'est fourni, définir Action à "help"
if (-not $Action) {
    $Action = "help"
}

# Obtient le chemin du dossier où le script est situé
$scriptPath = $PSScriptRoot
$powertoolsPath = Join-Path -Path $scriptPath -ChildPath "powertools.ps1"

# Appelle powertools.ps1 avec les mêmes paramètres
& $powertoolsPath -Action $Action @Arguments
