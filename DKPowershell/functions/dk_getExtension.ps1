if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_getExtension){ $dk_getExtension = 1 } else{ return }


##################################################################################
# dk_getExtension(path)
#
#
function Global:dk_getExtension () {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = (Get-Item $path ).Extension
	dk_printVar output
	return $output
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$extension = dk_getExtension "/path/to/a/filename.txt"
	echo "extension = ${extension}"
}