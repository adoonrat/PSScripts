# Install PSWindowsUpdate module if not already installed
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck
}

# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate

# Hide the progress UI
$ProgressPreference = 'SilentlyContinue'

# Search for available updates
$Updates = Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot

# Install the available updates
if ($Updates.Count -gt 0) {
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -IgnoreReboot -Install
}

# Reboot the system if updates were installed
if ($Updates.Count -gt 0) {
    Restart-Computer -Force
}
