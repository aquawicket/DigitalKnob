if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_isUrl){ $dk_isUrl = 1 } else{ return }


dk_load dk_stringContains
##################################################################################
# dk_isUrl(<str>)
#
#
function Global:dk_isUrl($str) {
	dk_debugFunc
	if($(__ARGC__) -ne 1){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if(dk_stringContains $str "://"){ return ${true} }
	return ${false}
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	$test_url = "http://www.aquawicket.com"
	
	if(dk_isUrl "${test_url}"){
		echo "variable is a url"
	} else {
		echo "variable is NOT a url"
	}
	
	
	$test_not_url = "readme.txt"
	if(dk_isUrl "${test_not_url}"){
		echo "variable is a url"
	} else {
		echo "variable is NOT a url"
	}
}