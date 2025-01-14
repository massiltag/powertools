# DESCRIPTION : Cr�e une nouvelle commande
# TAGS : powertools

param (
    [string]$CommandName
)

# V�rifie si le param�tre CommandName est fourni
if (-not $CommandName) {
    Write-Error "Veuillez fournir un nom de commande."
    exit
}

# Obtient le chemin du dossier o� le script est situ�
$scriptPath = $PSScriptRoot
$filePath = Join-Path -Path $scriptPath -ChildPath "$CommandName.ps1"

# Cr�e le fichier avec le contenu initial
$content = @"
# DESCRIPTION :
# TAGS :
"@
Set-Content -Path $filePath -Value $content -Encoding Default

# Ouvre le fichier avec Visual Studio Code en sp�cifiant l'encodage Windows 1252
Start-Process "code" -ArgumentList "$filePath" -NoNewWindow
