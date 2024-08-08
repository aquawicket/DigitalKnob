if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getDirectories){ $dk_getDirectories = 1 } else{ return }

################################################################################
# dk_getDirectories(path) -> rtn_var
#
#
#
function Global:dk_getDirectories($path) {
	dk_debugFunc 1

	
	
	$directories = Get-ChildItem $path | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}
	dk_printVar directories
	return $directories
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc
	
	
	$directories = dk_getDirectories "C:/Windows"
	dk_info "directories = $directories"
}	