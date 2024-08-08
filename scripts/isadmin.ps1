# DESCRIPTION : Vérifie si le shell est lancé avec les droits d'administrateur
# TAGS : util

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "Le shell est lancé en mode administrateur :)" -ForegroundColor Green
} else {
    Write-Host "Le shell n'est pas lancé en mode administrateur :(" -ForegroundColor Red
}
