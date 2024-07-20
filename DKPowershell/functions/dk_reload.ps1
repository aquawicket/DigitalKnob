if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_reload){ $dk_reload = 1 } else{ return }

##################################################################################
# dk_reload()
#
#
function Global:dk_reload() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	if(!(dk_pathExists "$DKSCRIPT_PATH")){ dk_error "DKSCRIPT_PATH is invalid"; return ${false} }
	
	#dk_echo
    dk_echo "reloading $DKSCRIPT_PATH"
	. "$DKSCRIPT_PATH" #& dk_exit & dk_exit & dk_exit
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_reload
}