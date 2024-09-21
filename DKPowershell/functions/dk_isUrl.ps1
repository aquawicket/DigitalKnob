if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_isUrl){ $dk_isUrl = 1 } else{ return }

##################################################################################
# dk_isUrl(str)
#
#
function Global:dk_isUrl($str) {
	dk_debugFunc 1
	
	if(dk_call dk_stringContains $str "://"){ $isUrl = $true }
	else{ $isUrl = $false }
	dk_call dk_printVar isUrl
	return $isUrl
}












###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$test_url = "http://www.aquawicket.com"
	
	if(dk_call dk_isUrl "${test_url}"){ dk_call dk_echo "variable is a url" } 
	else { dk_call dk_echo "variable is NOT a url" }
	
	$test_not_url = "readme.txt"
	if(dk_call dk_isUrl "${test_not_url}"){ dk_call dk_echo "variable is a url" } 
	else { dk_call dk_echo "variable is NOT a url" }
}
