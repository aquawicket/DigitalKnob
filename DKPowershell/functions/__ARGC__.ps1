if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$DK_ARGC){ $DK_ARGC = 1 } else{ return }

##################################################################################
# __ARGC__()
#
function GLOBAL:__ARGC__($_FRAME_=1) {
	
	return (Get-Command -Name $(__FUNCTION__ $($_FRAME_+1))).Parameters.count;
}