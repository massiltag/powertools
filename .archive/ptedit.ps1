# DESCRIPTION : Ouvre VSCode avec les fichiers PowerTools
# TAGS : util

# Obtient le chemin du dossier o� le script est situ�
$scriptPath = $PSScriptRoot

# Ouvre Visual Studio Code avec ce dossier et sp�cifie l'encodage Windows 1252
Start-Process "code" -ArgumentList "$scriptPath" -NoNewWindow
