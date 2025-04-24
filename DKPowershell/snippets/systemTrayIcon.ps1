# Show an icon in the System Tray (a.k.a. Notification Area)
# https://www.robvanderwoude.com/powershellsnippets.php#SystemTrayIcon
# System Tray ToolTip Balloon by Don Jones
# http://blog.sapien.com/current/2007/4/27/creating-a-balloon-tip-notification-in-powershell.html
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
# Base64 encoded icon
$b64convicon  = 'AAABAAEAEBAQAAEABAAoAQAAFgAAACgAAAAQAAAAIAAAAAEABAAAAAAAAAAAAAAA'
$b64convicon += 'AAAAAAAAAAAAAAAAAAAEAgQAhIKEAPz+/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
$b64convicon += 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
$b64convicon += 'AAAAAAAAAAAAAAAAAAAAEiEAAAICAAEgAgEAAgEgAgAAAgARACECAAAAACAAAgIA'
$b64convicon += 'AAEAIAACAgAAAgEQACEBIAIAAgABIAASIQACAAIAAAAAAAAAAAAAAAAAAAAAAAAA'
$b64convicon += 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
$b64convicon += 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
# Use Base64 encoded icon in code, by Kenny Baldwin
# https://foxdeploy.com/2013/10/23/creating-a-gui-natively-for-your-powershell-tools-using-net-methods/#comments
$icon = [System.Drawing.Icon]( New-Object System.Drawing.Icon( ( New-Object System.IO.MemoryStream( ( $$ = [System.Convert]::FromBase64String( $b64convicon ) ), 0, $$.Length ) ) ) )
$notify = new-object system.windows.forms.notifyicon
$notify.icon = $icon
$notify.visible = $true
# show the balloon for 10 seconds (will not show in Windows 10)
$notify.showballoontip( 10, "Reminder", "It's scripting time", [system.windows.forms.tooltipicon]::Info )
# Uncomment the next command line to remove the icon, or type it manually, or
# close the balloon and hover the mouse pointer over the system tray icon.
# $notify.Visible = $false
