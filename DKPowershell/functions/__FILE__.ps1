if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$__FILE__){ $__FILE__ = 1 } else{ return }

dk_load dk_info
##################################################################################
# __FILE__()
#
#
function GLOBAL:__FILE__() {
	#dk_debugFunc
	
	$global:__FILE__  = [string]($(Get-PSCallStack)[1].Location).Split(':')[0]
	return $__FILE__
}

