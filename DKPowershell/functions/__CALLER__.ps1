if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$__CALLER__){ $__CALLER__ = 1 } else{ return }


##################################################################################
# __CALLER__()
#
#
function GLOBAL:__CALLER__() {
	#dk_debugFunc
	
	$global:__CALLER__ = [string]($(Get-PSCallStack)[2].FunctionName).Split(':')[1]
	return $__CALLER__
}

