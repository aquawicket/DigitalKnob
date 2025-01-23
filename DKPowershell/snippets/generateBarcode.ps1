# Generate an EAN-13 barcode image
# https://www.robvanderwoude.com/powershellsnippets.php#GenerateEAN13Barcode
# This script requires EAN-13 font made available by Fontpalace.com:
# http://www.fontpalace.com/font-download/EAN-13/
# You can modify this script to generate any text in images, in which case you probably won't need the EAN-13 font
Add-Type -AssemblyName System.Drawing

# specify EAN-13 font
$font = New-Object -TypeName System.Drawing.Font( 'EAN-13', 48 )
# test if EAN-13 font is installed
if ( $font.Name -ne 'EAN-13' ) {
	$errormessage  = "`n `n`tThis script requires the `"EAN-13`" font made available by Fontpalace.com:"
	$errormessage += "`n`thttp://www.fontpalace.com/font-download/EAN-13/`n `n"
	Write-Error $errormessage -ErrorAction 'Stop'
}

$text            = $( Get-Date -Format 'yyyyMMddHHmmss' ).Substring( 0, 13 ) # or any other 13-digit number
# You can list all available text colors with the command: [System.Drawing.Brushes].DeclaredProperties.Name
$textcolor       = [System.Drawing.Brushes]::Black
# You can list all available background colors with the command: [enum]::GetNames( [System.Drawing.KnownColor] )
$backgroundcolor = [System.Drawing.Color]::White
$outputfile      = ( "D:\barcode{0}.jpg" -f $text )
# You can list available output formats with the command: [System.Drawing.Imaging.ImageFormat].DeclaredFields.Name
$outputformat    = [System.Drawing.Imaging.ImageFormat]::Jpeg

$bitmap     = New-Object -TypeName System.Drawing.Bitmap -ArgumentList 1,1
$graphic    = [System.Drawing.Graphics]::FromImage( $bitmap );
$stringsize = $graphic.MeasureString( $text, $font ) # calculate required image size
$bitmap     = New-Object -TypeName System.Drawing.Bitmap -ArgumentList $bitmap,$stringsize.Width,$stringsize.Height
$graphic    = [System.Drawing.Graphics]::FromImage( $bitmap )
$graphic.Clear( $backgroundcolor )
$graphic.DrawString( $text, $font, $textcolor, 0, 0 )
$font.Dispose( )
$graphic.Flush( )
$graphic.Dispose( )
$bitmap.Save( $outputfile, $outputformat )

# Open the image we just created
Start-Process -FilePath $outputfile
