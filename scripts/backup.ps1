# DESCRIPTION : Crée un backup zip instantané sur le bureau
# TAGS : util, backup

# Initialize the array with folders to backup and to ignore
$foldersToBackup = @(
    "C:\Env",
    "$env:USERPROFILE\Documents"
)

$ignoreFolders = @(
    "target",
    "node_modules",
    ".git",
    ".angular",
    "IntelliJ IDEA 2024.1"
)

# Construct 
$ignoreFoldersString = $ignoreFolders -join '\\|\\'
$ignoreFoldersString = '\\' + $ignoreFoldersString + '\\'

# Get the machine name
$machineName = $env:COMPUTERNAME

# Get the current date and time
$backupDate = Get-Date -Format "yyyyMMdd"
$backupTime = Get-Date -Format "HHmmss"

# Define the zip file name
$zipFileName = "$machineName-$backupDate-$backupTime.zip"

# Define the path to the zip file on the user's desktop
$desktopPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), $zipFileName)

# Create a temporary folder to store the files before zipping
$tempFolderPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "BackupTemp")
New-Item -ItemType Directory -Path $tempFolderPath -Force | Out-Null

# Get the total size of all items to be copied
Write-Host "Calculating total size..." -ForegroundColor Yellow
$totalSize = 0
foreach ($folder in $foldersToBackup) {
    $items = Get-ChildItem -Path $folder -Recurse -Force | Where-Object { 
        $_.FullName -notmatch $ignoreFoldersString
    }
    $totalSize += ($items | Measure-Object -Property Length -Sum).Sum
}
$totalSizeMB = [math]::Round($totalSize / 1MB, 2)

# Copy the folders to the temporary folder with progress
$copiedSize = 0
foreach ($folder in $foldersToBackup) {
    $folderName = [System.IO.Path]::GetFileName($folder.TrimEnd('\'))
    $destinationPath = [System.IO.Path]::Combine($tempFolderPath, $folderName)
    
    # Get all items in the folder, excluding "target" and "node_modules" subfolders recursively
    $items = Get-ChildItem -Path $folder -Recurse -Force | Where-Object { 
        $_.FullName -notmatch $ignoreFoldersString
    }
    
    foreach ($item in $items) {
        $relativePath = $item.FullName.Substring($folder.Length).TrimStart('\')
        $destPath = [System.IO.Path]::Combine($destinationPath, $relativePath)
        if ($item.PSIsContainer) {
            New-Item -ItemType Directory -Path $destPath -Force | Out-Null
        } else {
            Copy-Item -Path $item.FullName -Destination $destPath -Force
            $copiedSize += $item.Length
            $copiedSizeMB = [math]::Round($copiedSize / 1MB, 2)
            $percentComplete = [math]::Round(($copiedSize / $totalSize) * 100, 2)
            Write-Progress -Activity "Backing up files" -Status "Copying $($item.FullName)" -PercentComplete $percentComplete -CurrentOperation "$percentComplete% - $copiedSizeMB MB / $totalSizeMB MB"
        }
    }
}

# Create the zip file
Add-Type -AssemblyName "System.IO.Compression.FileSystem"
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempFolderPath, $desktopPath)

# Clean up the temporary folder
Remove-Item -Path $tempFolderPath -Recurse -Force

Write-Host "Backup completed successfully. Zip file created at $desktopPath" -ForegroundColor Green