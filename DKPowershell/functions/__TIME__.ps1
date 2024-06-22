if(!$DKINIT){ . $PWD/DK.ps1 }
#if(!$DK_TIME){ $DK_TIME = 1 } else{ return }

##################################################################################
# __TIME__()
#
function GLOBAL:__TIME__() {
	#return $(Get-PSCallStack)[$_FRAME_].ScriptLineNumber
	return Get-Date -Format HH:mm:ss.ffff
}




function Global:DKTEST() { ###########################################################################################
	Write-Host -Fore cyan "TIME = $(__TIME__)";
}