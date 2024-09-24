# DESCRIPTION : DÈmarre un hotspot Wi-Fi (Marche pas encore)
# TAGS : util, network

# D√©finir le SSID et le mot de passe souhait√©s
$ssid = "DELL"
$password = "12345678"

# V√©rifier si la carte r√©seau prend en charge l'h√©bergement de points d'acc√®s
$networkAdapter = Get-NetAdapter | Where-Object { $_.Name -like "*Wi-Fi*" }
if ($networkAdapter -eq $null) {
    Write-Host "Aucune carte rÈseau Wi-Fi trouvÈe."
    exit
}

# Cr√©er le point d'acc√®s mobile
$connectionSharingCmd = "netsh wlan set hostednetwork mode=allow ssid=$ssid key=$password"
Invoke-Expression $connectionSharingCmd

# D√©marrer le point d'acc√®s mobile
$startHostedNetworkCmd = "netsh wlan start hostednetwork"
Invoke-Expression $startHostedNetworkCmd

Write-Host "Point d'accËs mobile crÈÈ avec SSID: $ssid et mot de passe: $password."
