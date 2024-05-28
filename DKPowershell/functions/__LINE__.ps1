if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$DK_LINE){ $DK_LINE = 1 } else{ return }

##################################################################################
# __LINE__(<frame>)
#
function GLOBAL:__LINE__($_FRAME_=1) {
	
	return $(Get-PSCallStack)[$_FRAME_].ScriptLineNumber
}