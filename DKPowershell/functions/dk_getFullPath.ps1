if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

##################################################################################
# dk_getFullPath(path) -> rtn_var
#
#
function Global:dk_getFullPath($path) {
	dk_debugFunc 1

	$fullpath = dk_call dk_realpath $path 
	dk_call dk_printVar fullpath
	return $fullpath
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$fullpath = dk_call dk_getFullPath "bash"
	dk_call dk_echo "fullpath = ${fullpath}"
}
