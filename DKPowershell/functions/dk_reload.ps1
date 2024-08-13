if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_reload){ $dk_reload = 1 } else{ return }

##################################################################################
# dk_reload()
#
#
function Global:dk_reload() {
	dk_debugFunc 0

	if(!(dk_call dk_pathExists "${DKSCRIPT_PATH}")){ dk_call dk_error "DKSCRIPT_PATH is invalid"; return ${false} }
	
	#dk_call dk_echo
    dk_call dk_echo "reloading ${DKSCRIPT_PATH}"
	. "${DKSCRIPT_PATH}" #& dk_call dk_exit & dk_call dk_exit & dk_call dk_exit
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_reload
}
