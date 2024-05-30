if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_getFilename){ $dk_getFilename = 1 } else{ return }


##################################################################################
# dk_getFilename(<path> <output>)
#
#
function Global:dk_getFilename ($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = Split-Path $path -leaf
	dk_printVar output
	return $output
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$filename = dk_getFilename "/path/to/a/filename.txt"
	echo "filename = ${filename}"
}