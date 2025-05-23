# Take a screenshot
# https://www.robvanderwoude.com/powershellsnippets.php#ScreenShot
# Based on C# code by Ali Hamdar (http://alihamdar.com/)
# http://social.msdn.microsoft.com/Forums/en/csharpgeneral/thread/79efecc4-fa6d-4078-afe4-bb1379bb968b

$outputfile = 'C:/test.jpg'
$imagetype  = 'jpeg' # bmp, emf, gif, jpeg, png, tiff, wmf

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Default values for full screen
$width  = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
$height = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height
$top    = 0
$left   = 0

[System.Drawing.Bitmap]$printscreen = New-Object System.Drawing.Bitmap( $width, $height )
[System.Drawing.Graphics]$graphics  = [System.Drawing.Graphics]::FromImage( $printscreen )
$graphics.CopyFromScreen( $top, $left, 0, 0, $printscreen.Size )
$printscreen.Save( $outputfile, $imagetype ) # will overwrite existing file without prompt for confirmation

Start-Process -FilePath $outputfile # open the screenshot we just saved
