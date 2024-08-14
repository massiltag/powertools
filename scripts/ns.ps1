# DESCRIPTION : Démarre ou arrête Netskope
# TAGS : hacks, network, netskope

param (
    [ValidateSet("start", "stop")]
    [string]$action
)

# Start Netskope
function Start-Netskope {
    Start-Process -FilePath "C:\Program Files (x86)\Netskope\STAgent\stAgentSvc.exe"
    Write-Host "Netskope a été démarré." -ForegroundColor Green
}

# Stop Netskope
function Stop-Netskope {
    # Vérifie si le script est exécuté en tant qu'administrateur
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host "Veuillez relancer ce script avec les droits administrateur." -ForegroundColor Red
        exit
    }

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
}

# Main logic
if ($action -eq "start") {
    Start-Netskope
} elseif ($action -eq "stop") {
    while ($true) {
        Stop-Netskope
        Start-Sleep -Seconds 2
    }
}