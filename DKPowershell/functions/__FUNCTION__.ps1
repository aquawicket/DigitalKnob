if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$__FUNCTION__){ $__FUNCTION__ = 1 } else{ return }

dk_load dk_info
##################################################################################
# __FUNCTION__()
#
#
function GLOBAL:__FUNCTION__() {
	#dk_debugFunc
	
	$global:__FUNCTION__ = [string]($(Get-PSCallStack)[1].FunctionName).Split(':')[1]
	return $__FUNCTION__
}

