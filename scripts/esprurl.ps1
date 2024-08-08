# DESCRIPTION : Transforme l'URL de callback FranceConnect en URL de test local ESPR
# TAGS : work, util

param (
    [string]$url
)

Write-Host $url

# Extract the parts of the URL
if ($url -match "https://([^/]+)(/.*)") {
    $domain = $matches[1]
    $path = $matches[2]

    # Replace https with http and append :4200 to the domain
    $newUrl = "http://$domain`:4200$path"

    # Print the new URL
    # Write-Output $newUrl

    # Copy the new URL to the clipboard
    $newUrl | Set-Clipboard
    Write-Host "The new URL has been copied to the clipboard."
} else {
    Write-Output "Invalid URL format"
}