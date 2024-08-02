param (
    [string]$scriptPath,
    [string]$ScriptName
)

# D�finir le chemin du script � ex�cuter
$scriptToRun = Join-Path -Path $scriptPath -ChildPath "scripts\$ScriptName.ps1"

# V�rifier si le script existe
if (-Not (Test-Path -Path $scriptToRun)) {
    Write-Host "Le script '$ScriptName' n'existe pas." -ForegroundColor Red
    exit 1
}

# Ex�cuter le script
& $scriptToRun