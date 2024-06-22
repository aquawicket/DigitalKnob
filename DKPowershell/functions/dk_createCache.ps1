if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_createCache){ $dk_createCache = 1 } else{ return }

##################################################################################
# dk_createCache()
#
#
function Global:dk_createCache () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"${DKBRANCH_DIR}/cache"
	echo "$TARGET_OS">>"${DKBRANCH_DIR}/cache"
	echo "$TYPE">>"${DKBRANCH_DIR}/cache"
	#echo "$DKENV">>"${DKBRANCH_DIR}/cache"
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_createCache
}