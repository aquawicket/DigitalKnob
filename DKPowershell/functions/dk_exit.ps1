if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_error){ $dk_error = 1 } else{ return }


##################################################################################
# dk_exit()
#
#
function Global:dk_exit () {
	dk_debugFunc
	$allArgs = $PsBoundParameters.Values + $args
	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] && echo "exec $SHELL" || echo "exit $*"
	
	#[ $SHLVL -eq 1 ] && read -rp 'Press enter to exit...' key	
	exit $allArgs
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_exit
}