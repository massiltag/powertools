param (
    [string]$scriptPath,
    [array]$powertoolsCommands
)

Get-Content -Path "$PSScriptRoot\misc\header.txt" -Encoding UTF8

# Afficher les commandes powertools
Write-Host "=== Commandes ===" -ForegroundColor Green
$powertoolsCommands | Format-Table -Property "Commande", "Description" -AutoSize

# Lister les fichiers .ps1 dans le dossier scripts
Write-Host "`n=== Mes scripts ===" -ForegroundColor Green
$scriptsFolderPath = Join-Path -Path $scriptPath -ChildPath "scripts"
$files = Get-ChildItem -Path $scriptsFolderPath -Filter *.ps1

# Créer un tableau pour stocker les informations des fichiers
$fileInfo = @()

# Parcourir les fichiers et ajouter leurs informations au tableau
foreach ($file in $files) {
    # Lire les premières lignes du fichier
    $lines = Get-Content -Path $file.FullName -TotalCount 2

    # Initialiser les variables
    $description = "Aucune"
    $tags = "Aucun"

    # Vérifier si la première ligne commence par "# DESCRIPTION :"
    if ($lines[0] -match "^# DESCRIPTION : (.+)$") {
        $description = $matches[1]
    }

    # Vérifier si la deuxième ligne commence par "# TAGS :"
    if ($lines[1] -match "^# TAGS : (.+)$") {
        $tags = $matches[1]
    }

    # Ajouter les informations au tableau
    $fileInfo += [PSCustomObject]@{
        "Script"    = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        "Description" = $description
        "Tags"        = $tags
    }
}

# Trier les fichiers par tags, en plaçant les fichiers sans tags à la fin
$fileInfo = $fileInfo | Sort-Object -Property @{Expression = {if ($_.Tags -ne "Aucun tag") { $_.Tags.Split(',')[0].Trim() } else { [string]::Empty }}}, @{Expression = {if ($_.Tags -ne "Aucun tag" -and $_.Tags.Split(',').Count -gt 1) { $_.Tags.Split(',')[1].Trim() } else { [string]::Empty }}}, @{Expression = {if ($_.Tags -ne "Aucun tag" -and $_.Tags.Split(',').Count -gt 2) { $_.Tags.Split(',')[2].Trim() } else { [string]::Empty }}}, @{Expression = {if ($_.Tags -ne "Aucun tag") { 0 } else { 1 }}}

# Afficher le tableau avec des bordures et des colonnes ajustées
$fileInfo | Format-Table -Property "Script", "Description", "Tags" -AutoSize | Out-String | ForEach-Object { $_ -replace ' ', ' ' } | ForEach-Object { $_ -replace '\+', '|' } | ForEach-Object { $_ -replace '\-', '=' } | ForEach-Object { $_ -replace '\|', '+' }