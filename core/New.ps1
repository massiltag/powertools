param (
    [string]$scriptPath,
    [string]$CommandName
)

# Vérifie si le paramètre CommandName est fourni
if (-not $CommandName) {
    Write-Error "Veuillez fournir un nom de commande."
    exit
}

$filePath = Join-Path -Path $scriptPath -ChildPath "$CommandName.ps1"

# Crée le fichier avec le contenu initial
$content = @"
# DESCRIPTION :
# TAGS :
"@
Set-Content -Path $filePath -Value $content -Encoding Default

# Ouvre le fichier avec Visual Studio Code en spécifiant l'encodage Windows 1252
Start-Process "code" -ArgumentList "$filePath" -NoNewWindow
