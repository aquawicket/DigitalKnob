# winget
# https://learn.microsoft.com/en-us/windows/package-manager/winget

# Step 1: in Windows 11/10, type powershell into the search box and choose Run as Administrator in the popup.

# Step 2: Type Add-AppxPackage -Path C:\Path\App-Package.msixbundle into the window and press Enter. 
#	Replace C:\Path\App-Package.msixbundle with the path and name of your MSIXBundle package file, for example, 
#	Add-AppxPackage -Path C:\Users\cy\Desktop\Microsoft.WindowsTerminal_Win10_1.16.10261.0_8wekyb3d8bbwe.msixbundle
# Add-AppxPackage -Path C:\Users\aquawicket\digitalknob\download\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe