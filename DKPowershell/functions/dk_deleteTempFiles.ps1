if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_deleteTempFiles){ $dk_deleteTempFiles = 1 } else{ return }

##################################################################################
# dk_deleteTempFiles()
#
#
function Global:dk_deleteTempFiles() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	dk_info "Deleting .TMP files . . ."
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	Get-ChildItem -Path "$DIGITALKNOB_DIR" *.tmp -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
	Get-ChildItem -Path "$DIGITALKNOB_DIR" *.TMP -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_deleteTempFiles
}