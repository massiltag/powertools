param (
    [string]$scriptPath,
    [string]$ScriptName
)

# Définir le chemin du script à exécuter
$scriptToRun = Join-Path -Path $scriptPath -ChildPath "scripts\$ScriptName.ps1"

# Vérifier si le script existe
if (-Not (Test-Path -Path $scriptToRun)) {
    Write-Host "Le script '$ScriptName' n'existe pas." -ForegroundColor Red
    exit 1
}

# Exécuter le script
& $scriptToRun