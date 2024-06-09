if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_getDKPaths){ $dk_getDKPaths = 1 } else{ return }


##################################################################################
# dk_getExtension(<path> <output>)
#
#
function Global:dk_getExtension () {
	dk_debugFunc
	if ( $(__ARGC__) -ne 2 ){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = (Get-Item $path ).Extension
	dk_printVar output
	return $output
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$extension = dk_getExtension "/path/to/a/filename.txt"
	echo "extension = ${extension}"
}