if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_deleteTempFiles){ $dk_deleteTempFiles = 1 } else{ return }

##################################################################################
# dk_deleteTempFiles()
#
#
function Global:dk_deleteTempFiles() {
	dk_debugFunc 0



	dk_info "Deleting .TMP files . . ."
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	Get-ChildItem -Path "$DIGITALKNOB_DIR" *.tmp -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
	Get-ChildItem -Path "$DIGITALKNOB_DIR" *.TMP -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc
	
	
	dk_deleteTempFiles
}