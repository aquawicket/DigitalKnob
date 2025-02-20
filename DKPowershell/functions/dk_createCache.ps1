if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_createCache){ $dk_createCache = 1 } else{ return } #include guard

##################################################################################
# dk_createCache()
#
#
function Global:dk_createCache() {
	dk_debugFunc 0

	dk_call dk_echo "creating DKBuilder.cache..."
	
	# write variable values line by line
	echo "$target_app">"${DKCACHE_DIR}/DKBuilder.cache"
	echo "$target_triple">>"${DKCACHE_DIR}/DKBuilder.cache"
	echo "$target_type">>"${DKCACHE_DIR}/DKBuilder.cache"
	#echo "$DKENV">>"${DKCACHE_DIR}/DKBuilder.cache"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_createCache
}
