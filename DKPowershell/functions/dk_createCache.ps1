if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##################################################################################
# dk_createCache()
#
#
function Global:dk_createCache() {
	dk_debugFunc 0

	dk_call dk_echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"${DKCACHE_DIR}/cache"
	echo "$triple">>"${DKCACHE_DIR}/cache"
	echo "$TYPE">>"${DKCACHE_DIR}/cache"
	#echo "$DKENV">>"${DKCACHE_DIR}/cache"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_createCache
}
