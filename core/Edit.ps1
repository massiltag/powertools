param (
    [string]$scriptPath
)

# Ouvre Visual Studio Code avec ce dossier et spécifie l'encodage Windows 1252
Start-Process "code" -ArgumentList "$scriptPath" -NoNewWindow
