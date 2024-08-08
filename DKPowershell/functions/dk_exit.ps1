if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_exit){ $dk_exit = 1 } else{ return }

##################################################################################
# dk_exit()
#
#
function Global:dk_exit() {
	dk_debugFunc 0 1
	$allArgs = $PsBoundParameters.Values + ${args}
	# TODO: when open with icon, we can use exec to keep the window open
	#[ $SHLVL -gt 1 ] -and dk_echo "exec $SHELL" -or dk_echo "exit $*"
	
	#[ $SHLVL -eq 1 ] -and read -rp 'Press enter to exit...' key	
	exit $allArgs
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_exit
}