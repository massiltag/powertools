param (
    [string]$scriptPath,
    [string]$ScriptName,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Define the path of the script to run
$scriptToRun = Join-Path -Path $scriptPath -ChildPath "scripts\$ScriptName.ps1"

# Check if the script exists
if (-Not (Test-Path -Path $scriptToRun)) {
    Write-Host "Le script '$ScriptName' n'existe pas." -ForegroundColor Red
    exit 1
}

# Execute the script with the provided arguments
& $scriptToRun @Arguments