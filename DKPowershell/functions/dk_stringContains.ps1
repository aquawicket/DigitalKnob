if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_stringContains){ $dk_stringContains = 1 } else{ return }

dk_load dk_info
##################################################################################
# dk_stringContains(str, substring)
#
#
function Global:dk_stringContains($str, $substring) {
	dk_debugFunc
	if($(__ARGC__) -ne 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	if($str -like "*$substring*"){
		return $true
	}
	return $false
}





function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	

	if(dk_stringContains "1one1" "one"){ dk_echo "1one1 contains one" } 
	else { dk_echo "1one1 does not contain one" }

	if(dk_stringContains "2two2" "tow"){ dk_echo "2two2 contains tow" } 
	else { dk_echo "2two2 does not contain tow"}
}