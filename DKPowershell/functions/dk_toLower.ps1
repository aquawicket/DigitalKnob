if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_toLower){ $dk_toLower = 1 } else{ return }

##################################################################################
# dk_toLower(str) -> rtn_val
#
#
function Global:dk_toLower($str) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	$toLower = $str.ToLower()
	dk_printVar toLower
	return $toLower
}



function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	$lowercase = dk_toLower "CoNvErT tHiS sTrInG tO aLl LoWeRcAse"
	dk_echo "lowercase = ${lowercase}"
}