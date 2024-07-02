Set-ExecutionPolicy -ExecutionPolicy Unrestricted

Install-PackageProvider -Name Nuget -MinimumVersion 2.8.5.201 -Force

# Install PSWindowsUpdate module if not already installed
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck
}

# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate

$KB = "KB5039212"

# Hide the progress UI
#$ProgressPreference = 'SilentlyContinue'

# Search for available updates
$Updates = Get-WindowsUpdate -KBArticleID $KB -AcceptAll -IgnoreReboot

# Install the available updates
if ($Updates.Count -gt 0) {
    Install-WindowsUpdate -KBArticleID $KB -AcceptAll -IgnoreReboot -Install -verbose
}

# Reboot the system if updates were installed
if ($Updates.Count -gt 0) {
    Restart-Computer -Force
}
