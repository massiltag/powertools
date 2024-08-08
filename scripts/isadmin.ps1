# DESCRIPTION : V�rifie si le shell est lanc� avec les droits d'administrateur
# TAGS : util

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "Le shell est lanc� en mode administrateur :)" -ForegroundColor Green
} else {
    Write-Host "Le shell n'est pas lanc� en mode administrateur :(" -ForegroundColor Red
}
