if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_getFiles){ $dk_getFiles = 1 } else{ return } #include guard

################################################################################
# dk_getFiles(path) return -> rtn_var
#
#
#
function Global:dk_getFiles($path) {
	dk_debugFunc 1

	$files = Get-ChildItem $path | Where-Object {$_.PSIsContainer -eq $false} | Foreach-Object {$_.Name}
	dk_call dk_printVar files
	return $files
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$files = dk_call dk_getFiles "C:/Windows"
	dk_call dk_echo "files = $files"
}	
