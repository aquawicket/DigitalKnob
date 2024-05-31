if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_clearCmakeCache){ $dk_clearCmakeCache = 1 } else{ return }

dk_load dk_info
##################################################################################
# dk_clearCmakeCache()
#
#
function Global:dk_clearCmakeCache () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	# TODO: replace ${DIGITALKNOB_DIR} with $1 and call this functions while suplying the directory 
	dk_info "Clearing CMake cache . . ."	
	#find ${DIGITALKNOB_DIR} -name "CMakeCache.*" -delete
	#rm -rf $(find ${DIGITALKNOB_DIR} -type d -name CMakeFiles)
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_clearCmakeCache
}