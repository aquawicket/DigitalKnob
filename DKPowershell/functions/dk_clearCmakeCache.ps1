if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_clearCmakeCache){ $dk_clearCmakeCache = 1 } else{ return }

##################################################################################
# dk_clearCmakeCache()
#
#
function Global:dk_clearCmakeCache() {
	dk_debugFunc 0

	
	
	# TODO: replace ${DIGITALKNOB_DIR} with $1 and call this functions while suplying the directory 
	dk_info "Clearing CMake cache . . ."
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	cd "${DIGITALKNOB_DIR}"
	Get-ChildItem -Path "$DIGITALKNOB_DIR" CMakeCache.* -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
	Get-ChildItem -Path "$DIGITALKNOB_DIR" *CMakeFiles* -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
    
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	
	dk_clearCmakeCache
}