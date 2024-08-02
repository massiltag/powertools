param (
    [string]$scriptPath,
    [string]$CommandName
)

# Vérifie si le paramètre CommandName est fourni
if (-not $CommandName) {
    Write-Error "Veuillez fournir un nom de commande."
    exit
}

# Crée le chemin du dossier scripts
$scriptsFolderPath = Join-Path -Path $scriptPath -ChildPath "scripts"

# Vérifie si le dossier scripts existe, sinon le crée
if (-not (Test-Path -Path $scriptsFolderPath)) {
    New-Item -ItemType Directory -Path $scriptsFolderPath
}

$filePath = Join-Path -Path $scriptsFolderPath -ChildPath "$CommandName.ps1"

# Crée le fichier avec le contenu initial
$content = @"
# DESCRIPTION :
# TAGS :
"@
Set-Content -Path $filePath -Value $content -Encoding Default

# Ouvre le fichier avec Visual Studio Code en spécifiant l'encodage Windows 1252
Start-Process "code" -ArgumentList "$filePath" -NoNewWindow