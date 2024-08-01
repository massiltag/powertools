# DESCRIPTION : Ouvre VSCode avec les fichiers PowerTools
# TAGS : util

# Obtient le chemin du dossier où le script est situé
$scriptPath = $PSScriptRoot

# Ouvre Visual Studio Code avec ce dossier et spécifie l'encodage Windows 1252
Start-Process "code" -ArgumentList "$scriptPath" -NoNewWindow
