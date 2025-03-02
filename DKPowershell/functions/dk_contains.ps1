if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_contains){ $dk_contains = 1 } else{ return } #include guard

##################################################################################
# dk_contains(str, substring)
#
#
function Global:dk_contains($str, $substring) {
	dk_debugFunc 2

	if($str -like "*$substring*"){
		return $true
	}
	return $false
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0

	if(dk_call dk_contains "1one1" "one"){ dk_call dk_echo "1one1 contains one" } 
	else { dk_call dk_echo "1one1 does not contain one" }

	if(dk_call dk_contains "2two2" "tow"){ dk_call dk_echo "2two2 contains tow" } 
	else { dk_call dk_echo "2two2 does not contain tow"}
}
