<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_clearCmakeCache){ $dk_clearCmakeCache = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_clearCmakeCache){ $dk_clearCmakeCache = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_clearCmakeCache()
#
#
function Global:dk_clearCmakeCache() {
	dk_debugFunc 0

	# TODO: replace ${DIGITALKNOB_DIR} with $1 and call this functions while suplying the directory 
	dk_call dk_info "Clearing CMake cache . . ."
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	cd "${DKBRANCH_DIR}"
	Get-ChildItem -Path "$DKBRANCH_DIR" CMakeCache.* -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
	Get-ChildItem -Path "$DKBRANCH_DIR" *CMakeFiles* -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
    
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_clearCmakeCache
}
