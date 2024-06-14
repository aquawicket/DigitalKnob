if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getFullPath){ $dk_getFullPath = 1 } else{ return }

dk_load dk_realpath
##################################################################################
# dk_getFullPath(path) -> rtn_var
#
#
function Global:dk_getFullPath($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$fullpath = dk_realpath $path 
	dk_printVar fullpath
	return $fullpath
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	$fullpath = dk_getFullPath "bash"
	dk_echo "fullpath = ${fullpath}"
}