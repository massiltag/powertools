param (
    [string]$scriptPath
)

# Ouvre Visual Studio Code avec ce dossier et sp�cifie l'encodage Windows 1252
Start-Process "code" -ArgumentList "$scriptPath" -NoNewWindow
