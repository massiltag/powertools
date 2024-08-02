# DESCRIPTION : Arrête Netskope
# TAGS : network, netskope

# Vérifie si le script est exécuté en tant qu'administrateur
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Veuillez relancer ce script avec les droits administrateur." -ForegroundColor Red
    exit
}

# Arrête le service Netskope
if (Get-Process -Name "stAgentSvc" -ErrorAction SilentlyContinue) {
    try {
        Stop-Process -Name "stAgentSvc" -Force
        Write-Host "Netskope a été arrêté." -ForegroundColor Green
    } catch {
        Write-Host "Échec de l'arrêt de Netskope." -ForegroundColor Red
    }
} else {
    Write-Host "Netskope n'est pas en cours d'exécution." -ForegroundColor Red
}

