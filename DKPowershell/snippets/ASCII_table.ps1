# Fancy ASCII table
# https://www.robvanderwoude.com/powershellsnippets.php#FancyASCIITable
$columns = 8 # Number of columns, use any power of 2 to make the table fit on screen
0..( $columns - 1 ) | ForEach-Object {
	if ( $_ -eq 0 ) {
		Write-Host "Decimal`tASCII" -NoNewline
	} else {
		Write-Host "`t`tDecimal`tASCII" -NoNewline
	}
}
Write-Host
0..( $columns - 1 ) | ForEach-Object {
	if ( $_ -eq 0 ) {
		Write-Host "=======`t=====" -NoNewline
	} else {
		Write-Host "`t`t=======`t=====" -NoNewline
	}
}
Write-Host
0..( ( 256 / $columns ) - 1 ) | ForEach-Object {
	$startvalue = $columns * $_
	0..( $columns - 1 ) | ForEach-Object {
		$charvalue = $startvalue + $_
		if ( $_ -eq 0 ) {
			Write-Host ( "{0,7}`t{1,5}" -f $charvalue,[char]$charvalue ) -NoNewline
		} else {
			Write-Host ( "`t`t{0,7}`t{1,5}" -f $charvalue,[char]$charvalue ) -NoNewline
		}
	}
	Write-Host
}
