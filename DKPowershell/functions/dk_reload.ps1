if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_reload){ $dk_reload = 1 } else{ return } #include guard

##################################################################################
# dk_reload()
#
#
function Global:dk_reload() {
	dk_debugFunc 0

	if(!(dk_call dk_pathExists "${DKSCRIPT_PATH}")){ dk_call dk_error "DKSCRIPT_PATH is invalid"; return ${false} }
	
	dk_call dk_clearScreen
	dk_call dk_echo "reloading ${DKSCRIPT_PATH}"
	
	
	###### Method 1 ######
	dk_call dk_fileWrite "${DKPOWERSHELL_DIR}/reload" "${DKSCRIPT_PATH}" 
	dk_call dk_exit 0 
	

    ###### Method 2 ######
	. "${DKSCRIPT_PATH}" #& dk_call dk_exit & dk_call dk_exit & dk_call dk_exit
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pause "Press any key to test dk_reload"
	dk_call dk_reload
}
