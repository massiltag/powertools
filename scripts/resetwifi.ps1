# DESCRIPTION : Red�marre la carte WiFi
# TAGS : network

Restart-NetAdapter -Name "*Wi-Fi*"
Enable-NetAdapter -Name "Wi-Fi" -Confirm:$false