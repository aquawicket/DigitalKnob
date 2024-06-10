if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_getBasename){ $dk_getBasename = 1 } else{ return }

dk_load dk_printVar
################################################################################
# dk_getBasename(<path>)   return <output>
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_getBasename($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = (Get-Item $path).Basename
	dk_printVar output
	return $output
}




function Global:DKTEST() { ########################################################################

	$name = dk_getBasename "C:\Windows\System32"
	echo "name = $name"
	
	$namb = dk_getBasename "TEST"
	echo "nameb = $nameb"
}