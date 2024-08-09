param (
    [string]$scriptPath
)

# Ouvre Visual Studio Code avec ce dossier
Start-Process "code" -ArgumentList "$scriptPath" -NoNewWindow
