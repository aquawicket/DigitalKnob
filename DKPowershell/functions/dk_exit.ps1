if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_exit){ $dk_exit = 1 } else{ return }


##################################################################################
# dk_exit()
#
#
function Global:dk_exit () {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] -and echo "exec $SHELL" -or echo "exit $*"
	
	#[ $SHLVL -eq 1 ] -and read -rp 'Press enter to exit...' key	
	exit $allArgs
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_exit
}