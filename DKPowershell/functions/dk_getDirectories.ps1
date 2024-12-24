if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

################################################################################
# dk_getDirectories(path) -> rtn_var
#
#
#
function Global:dk_getDirectories($path) {
	dk_debugFunc 1

	$directories = Get-ChildItem $path | Where-Object {$_.PSIsContainer} | Foreach-Object {$_.Name}
	dk_call dk_printVar directories
	return $directories
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$directories = dk_call dk_getDirectories "C:/Windows"
	dk_call dk_info "directories = $directories"
}	
