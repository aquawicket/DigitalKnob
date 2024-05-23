if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$DK_CALLER){ $DK_CALLER = 1 } else{ return }

##################################################################################
# __CALLER__()
#
function GLOBAL:__CALLER__($_FRAME_=1) {

	return ($(Get-PSCallStack)[$_FRAME_+1].FunctionName).Split(':')[1]
}