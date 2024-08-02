# DESCRIPTION : Vérifie si le shell est lancé avec les droits d'administrateur
# TAGS : util

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Output "Le shell est lancé en mode administrateur :)`n"
} else {
    Write-Output "Le shell n'est pas lancé en mode administrateur :(`n"
}
