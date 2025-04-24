# Get screen width in pixels
# https://www.robvanderwoude.com/powershellsnippets.php#GetScreenWidth
Add-Type -AssemblyName System.Windows.Forms
( [System.Windows.Forms.Screen]::AllScreens | where-Object { $_.Primary } ).WorkingArea.Width # current value for primary monitor

# or:

[System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width # current value for primary monitor

# or:

[System.Windows.Forms.SystemInformation]::PrimaryMonitorMaximizedWindowSize.Width # maximum available width on primary monitor

# or:

( Get-CimInstance -ClassName Win32_DesktopMonitor ).ScreenWidth # maximum value for primary monitor

# or:

( Get-CimInstance -ClassName Win32_VideoController ).CurrentHorizontalResolution # current value for single video card and monitor
