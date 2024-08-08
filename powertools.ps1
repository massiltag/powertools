# DESCRIPTION : Script de base Powertools
# TAGS : powertools

param (
    [ValidateSet("run", "edit", "new", "help")]
    [string]$Action,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Si aucun paramètre n'est fourni, définir Action à "help"
if (-not $Action) {
    $Action = "help"
}

# Définir le chemin du script
$scriptPath = $PSScriptRoot
$functionPath = Join-Path -Path $scriptPath -ChildPath "core"

# Lire les noms et descriptions des commandes à partir du fichier JSON
$cmdInfosFile = Join-Path -Path $functionPath -ChildPath "cmd-infos.json"
$powertoolsCommands = Get-Content -Path $cmdInfosFile | ConvertFrom-Json

# Exécution du code associé en fonction du paramètre Action
switch ($Action) {
    "run" {
        . (Join-Path -Path $functionPath -ChildPath "Run.ps1") -scriptPath $scriptPath @Arguments
    }
    "edit" {
        . (Join-Path -Path $functionPath -ChildPath "Edit.ps1") -scriptPath $scriptPath
    }
    "new" {
        . (Join-Path -Path $functionPath -ChildPath "New.ps1") -scriptPath $scriptPath @Arguments
    }
    "help" {
        . (Join-Path -Path $functionPath -ChildPath "Help.ps1") -scriptPath $scriptPath -powertoolsCommands $powertoolsCommands
    }
}
