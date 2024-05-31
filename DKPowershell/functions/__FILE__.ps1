if (!$DKINIT){ . $PWD\DK.ps1 }
#if (!$DK_FILE){ $DK_FILE = 1 } else{ return }

##################################################################################
# __FILE__(<frame>)
#
function GLOBAL:__FILE__($_FRAME_=1) {
	return ($(Get-PSCallStack)[$_FRAME_].Location).Split(':')[0]
}



function Global:DKTEST() { ###########################################################################################
	Write-Host -Fore cyan "FILE = $(__FILE__)";
}