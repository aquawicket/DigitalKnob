param (
[string]$name, 
[string]$url, 
[string]$exe,
[string]$ptemp = "c:\temp\png",
[string]$icofold = "c:\Icons\",
[string]$s2url = "https://t2.gstatic.com/faviconV2?client=SOCIAL&type=FAVICON&fallback_opts=TYPE,SIZE,URL&url="
)

#Append Icon URl if needed
if ($url.SubString(0,8) -like 'https://') {}
else { $url = $url.Insert(0,'https://')}
$iconurl = -join($s2url, $url, "&size=64")

#Verify temp directory and save .png
if (Test-Path $ptemp) {}
else { New-Item $ptemp -ItemType Directory}
$temppng = -join($ptemp, "/", $name, ".png")
Invoke-WebRequest -UseBasicParsing -uri $iconurl -outfile $temppng

#Verify Icon Folder exists
if (Test-Path $icofold) {}
else { New-Item $icofold -ItemType Directory}

#Convert to .ico and save
Add-Type -AssemblyName System.Drawing
$iconpath = -join($icofold, $name, ".ico")
    $img = [System.Drawing.Image]::FromFile($temppng)
    $img.Save($iconPath, [System.Drawing.Imaging.ImageFormat]::Icon)
    $img.Dispose()

#Create Shortcut on public Desktop
$desktopDir = Join-Path -Path $env:PUBLIC -ChildPath "Desktop"
$destinationPath = Join-Path -Path $desktopDir -ChildPath "$name.lnk"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($destinationPath)
$Shortcut.TargetPath = $exe
$Shortcut.Arguments = $url
$Shortcut.IconLocation = $iconpath
$Shortcut.Save()

#cleanup
remove-item $temppng