if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_realpath){ $dk_realpath = 1 } else{ return }

dk_load dk_error
dk_load dk_printVar
##################################################################################
# dk_realpath(<path>) return <output>
#
#
function Global:dk_realpath($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = Resolve-Path -Path "$path"
	dk_printVar output
	return ${output}
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$_realpath = dk_realpath dk_load.ps1 
	echo "_realpath = ${_realpath}"
}