if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_removeExtension){ $dk_removeExtension = 1 } else{ return }

dk_load dk_printVar
##################################################################################
# dk_removeExtension(<filepath> <output>)
#
#
function Global:dk_removeExtension($filepath) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	$output = $filepath.Substring(0, $filepath.lastIndexOf('.'))
	dk_printVar output
	return $output
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$filepath="C:/test/test2/xfile.version.1.2.ext"
	$name = dk_removeExtension $filepath
	echo "name = ${name}"
}