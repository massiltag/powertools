# DESCRIPTION : D�marre un hotspot Wi-Fi (Marche pas encore)
# TAGS : util, network

# Définir le SSID et le mot de passe souhaités
$ssid = "DELL"
$password = "12345678"

# Vérifier si la carte réseau prend en charge l'hébergement de points d'accès
$networkAdapter = Get-NetAdapter | Where-Object { $_.Name -like "*Wi-Fi*" }
if ($networkAdapter -eq $null) {
    Write-Host "Aucune carte r�seau Wi-Fi trouv�e."
    exit
}

# Créer le point d'accès mobile
$connectionSharingCmd = "netsh wlan set hostednetwork mode=allow ssid=$ssid key=$password"
Invoke-Expression $connectionSharingCmd

# Démarrer le point d'accès mobile
$startHostedNetworkCmd = "netsh wlan start hostednetwork"
Invoke-Expression $startHostedNetworkCmd

Write-Host "Point d'acc�s mobile cr�� avec SSID: $ssid et mot de passe: $password."
