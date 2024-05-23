if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$__ARGC__){ $__ARGC__ = 1 } else{ return }

dk_load dk_info
##################################################################################
# __ARGC__()
#
#
function GLOBAL:__ARGC__() {
	#dk_debugFunc
	
	$global:__FUNCTION__ = [string]($(Get-PSCallStack)[1].FunctionName).Split(':')[1]
	$global:__ARGC__ = (Get-Command -Name $__FUNCTION__).Parameters.count;
	return $__ARGC__
}

