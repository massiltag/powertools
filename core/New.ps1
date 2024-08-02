param (
    [string]$scriptPath,
    [string]$CommandName
)

# V�rifie si le param�tre CommandName est fourni
if (-not $CommandName) {
    Write-Error "Veuillez fournir un nom de commande."
    exit
}

# Cr�e le chemin du dossier scripts
$scriptsFolderPath = Join-Path -Path $scriptPath -ChildPath "scripts"

# V�rifie si le dossier scripts existe, sinon le cr�e
if (-not (Test-Path -Path $scriptsFolderPath)) {
    New-Item -ItemType Directory -Path $scriptsFolderPath
}

$filePath = Join-Path -Path $scriptsFolderPath -ChildPath "$CommandName.ps1"

# Cr�e le fichier avec le contenu initial
$content = @"
# DESCRIPTION :
# TAGS :
"@
Set-Content -Path $filePath -Value $content -Encoding Default

# Ouvre le fichier avec Visual Studio Code en sp�cifiant l'encodage Windows 1252
Start-Process "code" -ArgumentList "$filePath" -NoNewWindow