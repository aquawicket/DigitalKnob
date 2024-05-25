if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_color){ $dk_color = 1 } else{ return }

#####################################################################
## dk_color()
##
## https://evotec.xyz/powershell-how-to-format-powershell-write-host-with-multiple-colors/
##
function Global:dk_color() {
	
	Write-Host "Whole text is in green" -ForegroundColor Green
	Write-Host "Whole text is in red" -ForegroundColor Red
	Write-Host "Whole text is in white" -ForegroundColor White

	Write-Host "Whole text is in red with background Yellow" -ForegroundColor Red -BackgroundColor Yellow
	Write-Host "Whole text is in yellow with background Dark Green" -ForegroundColor Yellow -BackgroundColor DarkGreen
	
	Write-Host "Green " -ForegroundColor Green -NoNewline; 
	Write-Host "Red " -ForegroundColor Red -NoNewline; 
	Write-Host "Yellow " -ForegroundColor Yellow;
	
	Write-Host "Green " -ForegroundColor Green -NoNewline; Write-Host "Red " -ForegroundColor Red -NoNewline; Write-Host "Yellow " -ForegroundColor Yellow;
}






function Global:DKTEST() { ###########################################################################################
	
	dk_color
}