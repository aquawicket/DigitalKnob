<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_deleteTempFiles){ $dk_deleteTempFiles = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_deleteTempFiles){ $dk_deleteTempFiles = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_deleteTempFiles()
#
#
function Global:dk_deleteTempFiles() {
	dk_debugFunc 0

	dk_call dk_info "Deleting .TMP files . . ."
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	Get-ChildItem -Path "$DKBRANCH_DIR" *.tmp -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
	Get-ChildItem -Path "$DKBRANCH_DIR" *.TMP -Recurse | foreach { Remove-Item -Path $_.FullName -Recurse }
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_deleteTempFiles
}
