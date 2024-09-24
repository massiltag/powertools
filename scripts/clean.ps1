# DESCRIPTION : Supprime les raccourcis par défaut du bureau et de la barre des tâches
# TAGS : hacks

# Clean desktop
# Define the path to the directory
$directoryPath = "C:\Users\Public\Desktop"

# Get all .lnk files in the directory
$files = Get-ChildItem -Path $directoryPath -Filter *.lnk

# Loop through each file and delete it
foreach ($file in $files) {
    Remove-Item -Path $file.FullName -Force
    Write-Output "Deleted: $($file.FullName)"
}


# Clean taskbar
# Define the shortcuts to remove
$shortcutsToRemove = @("Microsoft Edge.lnk", "Outlook.lnk", "Client SCCM.lnk")

# Path to the pinned taskbar shortcuts folder
$taskbarPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

# Check if the path exists
if (-Not (Test-Path -Path $taskbarPath)) {
    Write-Output "Taskbar path not found: $taskbarPath"
    exit
}

# Remove each specified shortcut
foreach ($shortcut in $shortcutsToRemove) {
    $filePath = Join-Path -Path $taskbarPath -ChildPath $shortcut
    if (Test-Path -Path $filePath) {
        try {
            Remove-Item -Path $filePath -Force
        } catch { }
    } else {
        Write-Output "Shortcut not found: $filePath"
    }
}

Remove-Item -Path "$env:USERPROFILE\Desktop\Applications GENERALI" -Recurse -Force

Write-Output "Operation completed."

