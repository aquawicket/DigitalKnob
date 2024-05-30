if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_toLower){ $dk_toLower = 1 } else{ return }

dk_load dk_printVar
##################################################################################
# dk_toLower(<str>) return <output>
#
#
function Global:dk_toLower($str) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	$output = $str.ToLower()
	dk_printVar output
	return $output
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$lowercase = dk_toLower "CoNvErT tHiS sTrInG tO aLl LoWeRcAse"
	echo "lowercase = ${lowercase}"
}