if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}\DK.ps1; }
if(!$dk_test_ps1){ $dk_test_ps1 = 1; } else{ return; } #include guard


##################################################################################
# dk_includes(string, substring)
#
#
function GLOBAL:dk_includes() {
	dk_call dk_debugFunc 2;

	if($args[0] -Match $args[1]){
		${global:dk_includes} = $true;
	}
	else{
		${global:dk_includes} = $false;
	}
	
	return ${dk_includes};
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function GLOBAL:DKTEST() {
	dk_call dk_debugFunc 2;

	### Result as global variable
	dk_call dk_echo;
	dk_call dk_echo 'dk_includes "1one1" "one"';
	dk_call dk_includes "1one1" "one";
	dk_call dk_echo "dk_includes = ${dk_includes}";
	
	
	### Result as a condition (true)
	dk_call dk_echo;
	dk_call dk_echo 'dk_includes "2two2" "two"';
	if(dk_call dk_includes "2two2" "two"){ 
		dk_call dk_echo "2two2 contains two"; 
	} 
	else{ 
		dk_call dk_echo "2two2 does NOT contain two"; 
	}
	dk_call dk_echo "dk_includes = ${dk_includes}";
	
	
	### Result as a condition (false)
	dk_call dk_echo;
	dk_call dk_echo 'dk_includes "3three3" "four"';
	if(dk_call dk_includes "3three3" "four"){ 
		dk_call dk_echo "3three3 contains four"; 
	}
	else{ 
		dk_call dk_echo "3three3 does NOT contain four"; 
	}
	dk_call dk_echo "dk_includes = ${dk_includes}";
	
}
