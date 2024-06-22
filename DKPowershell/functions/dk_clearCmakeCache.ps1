if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_clearCmakeCache){ $dk_clearCmakeCache = 1 } else{ return }

##################################################################################
# dk_clearCmakeCache()
#
#
function Global:dk_clearCmakeCache () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	# TODO: replace ${DIGITALKNOB_DIR} with $1 and call this functions while suplying the directory 
	dk_info "Clearing CMake cache . . ."
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	cd "${DIGITALKNOB_DIR}"
	Get-ChildItem -Path "$DIGITALKNOB_DIR" CMakeCache.* -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
	Get-ChildItem -Path "$DIGITALKNOB_DIR" *CMakeFiles* -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
    
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_clearCmakeCache
}