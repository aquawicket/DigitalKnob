if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_listToArray_ps1){ $dk_listToArray_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_listToArray(<list>, <rtn_var:OPTIONAL>)
#
#
function Global:dk_listToArray() {
    dk_call dk_debugFunc 1 3;
    
	${global:dk_listToArray} = $args[0].Split(";");
	
	if($args[1]) {
		dk_call dk_set $args[1] ${dk_listToArray};
	} else {
		return ${dk_listToArray};
	}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	dk_call dk_debugFunc 0;

	### Result as global variable
	dk_call dk_echo;
	dk_call dk_listToArray "a;b;c;d;e";
	dk_call dk_printVar dk_listToArray;
	
	### Result as return value
	dk_call dk_echo;
	$resultA = dk_call dk_listToArray "1;2;3;4;5";
	dk_call dk_printVar resultA;
	dk_call dk_printVar dk_listToArray;
	
	### Result as parameter
	dk_call dk_echo;
	dk_call dk_listToArray "z;y;x;w;v" resultB;
	dk_call dk_printVar resultB;
	dk_call dk_printVar dk_listToArray;
}
