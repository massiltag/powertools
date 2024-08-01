# DESCRIPTION : Script de base Powertools
# TAGS : powertools

param (
    [ValidateSet("edit", "new", "help")]
    [string]$Action,
    [string]$CommandName
)

# Définir le chemin du script
$scriptPath = $PSScriptRoot
$functionPath = Join-Path -Path $scriptPath -ChildPath "ptscripts"

# Lire les noms et descriptions des commandes à partir du fichier JSON
$cmdInfosFile = Join-Path -Path $functionPath -ChildPath "cmd-infos.json"
$powertoolsCommands = Get-Content -Path $cmdInfosFile | ConvertFrom-Json

# Exécution du code associé en fonction du paramètre Action
switch ($Action) {
    "edit" {
        . (Join-Path -Path $functionPath -ChildPath "Edit.ps1") -scriptPath $scriptPath
    }
    "new" {
        . (Join-Path -Path $functionPath -ChildPath "New.ps1") -scriptPath $scriptPath -CommandName $CommandName
    }
    "help" {
        . (Join-Path -Path $functionPath -ChildPath "Help.ps1") -scriptPath $scriptPath -powertoolsCommands $powertoolsCommands
    }
}
