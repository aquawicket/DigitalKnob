if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getFullPath){ $dk_getFullPath = 1 } else{ return }

dk_load dk_realpath
##################################################################################
# dk_getFullPath(path, rtn_var)
#
#
function Global:dk_getFullPath($path, $rtn_var) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$fullpath = dk_realpath $path 
	dk_printVar fullpath
	return $fullpath
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$fullpath = dk_getFullPath "bash"
	echo "fullpath = ${fullpath}"
}