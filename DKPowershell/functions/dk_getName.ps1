if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_getFilename){ $dk_getFilename = 1 } else{ return }

dk_load dk_printVar
################################################################################
# dk_getName(<path>)   return <output>
#
#    reference: https://stackoverflow.com/a/59739663/688352
#
function Global:dk_getName($path) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$output = (Get-Item $path).Basename
	dk_printVar output
	return $output
}




function Global:DKTEST() { ########################################################################

	$name = dk_getName "C:\Windows\System32"
	echo "name = $name"
	
	$namb = dk_getName "TEST"
	echo "nameb = $nameb"
}