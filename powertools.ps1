# DESCRIPTION : Script de base Powertools
# TAGS : powertools

param (
    [ValidateSet("run", "edit", "new", "help")]
    [string]$Action,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Si aucun param�tre n'est fourni, d�finir Action � "help"
if (-not $Action) {
    $Action = "help"
}

# D�finir le chemin du script
$scriptPath = $PSScriptRoot
$functionPath = Join-Path -Path $scriptPath -ChildPath "core"

# Lire les noms et descriptions des commandes � partir du fichier JSON
$cmdInfosFile = Join-Path -Path $functionPath -ChildPath "cmd-infos.json"
$powertoolsCommands = Get-Content -Path $cmdInfosFile | ConvertFrom-Json

# Ex�cution du code associ� en fonction du param�tre Action
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
