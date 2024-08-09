param (
    [string]$scriptPath,
    [string]$CommandName
)

# Check if the CommandName parameter is provided
if (-not $CommandName) {
    Write-Error "Veuillez fournir un nom de commande."
    exit
}

# Create the path for the scripts folder
$scriptsFolderPath = Join-Path -Path $scriptPath -ChildPath "scripts"

# Check if the scripts folder exists, if not, create it
if (-not (Test-Path -Path $scriptsFolderPath)) {
    New-Item -ItemType Directory -Path $scriptsFolderPath
}

$filePath = Join-Path -Path $scriptsFolderPath -ChildPath "$CommandName.ps1"

# Create the file with initial content
$content = @"
# DESCRIPTION :
# TAGS :
"@
Set-Content -Path $filePath -Value $content -Encoding Default

# Open the file with Visual Studio Code
Start-Process "code" -ArgumentList "$filePath" -NoNewWindow