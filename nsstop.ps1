# DESCRIPTION : Arr�te Netskope
# TAGS : network, netskope

# V�rifie si le script est ex�cut� en tant qu'administrateur
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Veuillez relancer ce script avec les droits administrateur." -ForegroundColor Red
    exit
}

# Arr�te le service Netskope
if (Get-Process -Name "stAgentSvc" -ErrorAction SilentlyContinue) {
    try {
        Stop-Process -Name "stAgentSvc" -Force
        Write-Host "Netskope a �t� arr�t�." -ForegroundColor Green
    } catch {
        Write-Host "�chec de l'arr�t de Netskope." -ForegroundColor Red
    }
} else {
    Write-Host "Netskope n'est pas en cours d'ex�cution." -ForegroundColor Red
}

