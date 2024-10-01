if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_createCache){ $dk_createCache = 1 } else{ return }

##################################################################################
# dk_createCache()
#
#
function Global:dk_createCache() {
	dk_debugFunc 0

	dk_call dk_echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"${DKBRANCH_DIR}/cache"
	echo "$triple">>"${DKBRANCH_DIR}/cache"
	echo "$TYPE">>"${DKBRANCH_DIR}/cache"
	#echo "$DKENV">>"${DKBRANCH_DIR}/cache"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_createCache
}
