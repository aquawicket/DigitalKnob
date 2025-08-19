if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_contains_ps1){ $dk_contains_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_contains(str, substring)
#
#
function Global:dk_contains() {
	dk_debugFunc 2;

	if($($args[0]) -like "*$($args[1])*"){
		return $true;
	}
	return $false;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;

	if(dk_call dk_contains "1one1" "one"){ 
		dk_call dk_echo "1one1 contains one\n"; 
	}
	else { 
		dk_call dk_echo "1one1 does NOT contain one\n"; 
	}

	if(dk_call dk_contains "2two2" "tow"){ 
		dk_call dk_echo "2two2 contains tow\n"; 
	}
	else { 
		dk_call dk_echo "2two2 does NOT contain tow\n"; 
	}
}
