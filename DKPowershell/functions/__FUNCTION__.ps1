if (!$DKINIT){ . $PWD\DK.ps1 }
#if (!$DK_FUNCTION){ $DK_FUNCTION = 1 } else{ return }

##################################################################################
# __FUNCTION__(<frame>)
#
function GLOBAL:__FUNCTION__($_FRAME_=1) {
	return ($(Get-PSCallStack)[$_FRAME_].FunctionName).Split(':')[1]
}




function Global:DKTEST() { ###########################################################################################
	Write-Host -Fore cyan "FUNCTION = $(__FUNCTION__)";
}