# DESCRIPTION : Autorise les connexions à des comptes personnels sur OneNote
# TAGS : hacks

# Check if the script is being run as an Administrator
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$adminRole = [Security.Principal.WindowsBuiltinRole]::Administrator
$isAdmin = (New-Object Security.Principal.WindowsPrincipal($currentUser)).IsInRole($adminRole)

if (-not $isAdmin) {
    Write-Host "Please run this script as an Administrator."
    exit
}

# Set the registry key value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftAccount"
$registryName = "DisableUserAuth"
$registryValue = 0

# Ensure the registry path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry key
Set-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -Force

# Confirm the value was set
$value = Get-ItemProperty -Path $registryPath -Name $registryName
Write-Host "Registry key $registryName has been set to $($value.$registryName)"
