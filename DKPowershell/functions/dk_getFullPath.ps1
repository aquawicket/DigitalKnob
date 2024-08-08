if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getFullPath){ $dk_getFullPath = 1 } else{ return }

##################################################################################
# dk_getFullPath(path) -> rtn_var
#
#
function Global:dk_getFullPath($path) {
	dk_debugFunc 1

	
	
	$fullpath = dk_realpath $path 
	dk_printVar fullpath
	return $fullpath
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc
	
	
	$fullpath = dk_getFullPath "bash"
	dk_echo "fullpath = ${fullpath}"
}