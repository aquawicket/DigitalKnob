if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$__LINE__){ $__LINE__ = 1 } else{ return }

dk_load dk_info
##################################################################################
# __LINE__()
#
#
function GLOBAL:__LINE__() {
	#dk_debugFunc
	
	$global:__LINE__   = [string]$(Get-PSCallStack)[1].ScriptLineNumber
	return $__LINE__
}

