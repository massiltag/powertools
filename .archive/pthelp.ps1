# DESCRIPTION : Affiche les commandes disponibles
# TAGS : util

# Obtenir le chemin du dossier o� le script est situ�
$scriptPath = $PSScriptRoot

# Lister les fichiers .ps1 dans le dossier
$files = Get-ChildItem -Path $scriptPath -Filter *.ps1

# Cr�er un tableau pour stocker les informations des fichiers
$fileInfo = @()

# Parcourir les fichiers et ajouter leurs informations au tableau
foreach ($file in $files) {
    # Lire les premi�res lignes du fichier
    $lines = Get-Content -Path $file.FullName -TotalCount 2

    # Initialiser les variables
    $description = "-"
    $tags = "-"

    # V�rifier si la premi�re ligne commence par "# DESCRIPTION :"
    if ($lines[0] -match "^# DESCRIPTION : (.+)$") {
        $description = $matches[1]
    }

    # V�rifier si la deuxi�me ligne commence par "# TAGS :"
    if ($lines[1] -match "^# TAGS : (.+)$") {
        $tags = $matches[1]
    }

    # Ajouter les informations au tableau
    $fileInfo += [PSCustomObject]@{
        "Commande"    = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        "Description" = $description
        "Tags"        = $tags
    }
}

# Trier les fichiers par tags, en pla�ant les fichiers sans tags � la fin
$fileInfo = $fileInfo | Sort-Object -Property @{Expression = {if ($_.Tags -ne "Aucun tag") { $_.Tags.Split(',')[0].Trim() } else { [string]::Empty }}}, @{Expression = {if ($_.Tags -ne "Aucun tag" -and $_.Tags.Split(',').Count -gt 1) { $_.Tags.Split(',')[1].Trim() } else { [string]::Empty }}}, @{Expression = {if ($_.Tags -ne "Aucun tag" -and $_.Tags.Split(',').Count -gt 2) { $_.Tags.Split(',')[2].Trim() } else { [string]::Empty }}}, @{Expression = {if ($_.Tags -ne "Aucun tag") { 0 } else { 1 }}}

# Afficher le tableau avec des bordures et des colonnes ajust�es
$fileInfo | Format-Table -Property "Commande", "Description", "Tags" -AutoSize | Out-String | % { $_ -replace ' ', ' ' } | % { $_ -replace '\+', '|' } | % { $_ -replace '\-', '=' } | % { $_ -replace '\|', '+' }