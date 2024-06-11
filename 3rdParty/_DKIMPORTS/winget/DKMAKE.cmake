include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# winget
# https://learn.microsoft.com/en-us/windows/package-manager/winget

# Step 1: in Windows 11/10, type powershell into the search box and choose Run as Administrator in the popup.

# Step 2: Type Add-AppxPackage -Path C:\Path\App-Package.msixbundle into the window and press Enter. 
#	Replace C:\Path\App-Package.msixbundle with the path and name of your MSIXBundle package file, for example, 
#	Add-AppxPackage -Path C:\Users\cy\Desktop\Microsoft.WindowsTerminal_Win10_1.16.10261.0_8wekyb3d8bbwe.msixbundle
# Add-AppxPackage -Path C:\Users\aquawicket\digitalknob\download\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

Import-Module Appx -UseWindowsPowershell

Invoke-WebRequest `
    -URI https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6 `
    -OutFile xaml.zip -UseBasicParsing
New-Item -ItemType Directory -Path xaml
Expand-Archive -Path xaml.zip -DestinationPath xaml
Add-AppxPackage -Path "xaml\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx"
Remove-Item xaml.zip
Remove-Item xaml -Recurse

# Get the download URL of the latest winget installer from GitHub:
$API_URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
$DOWNLOAD_URL = $(Invoke-RestMethod $API_URL).assets.browser_download_url |
    Where-Object {$_.EndsWith(".msixbundle")}

# Download the installer:
Invoke-WebRequest -URI $DOWNLOAD_URL -OutFile winget.msixbundle -UseBasicParsing

# Install winget:
Add-AppxPackage winget.msixbundle

# Remove the installer:
Remove-Item winget.msixbundle