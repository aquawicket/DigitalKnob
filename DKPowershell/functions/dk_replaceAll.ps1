if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_replaceAll_ps1){ $dk_replaceAll_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_replaceAll(input, searchValue, newValue) -> rtn_var
#
#
function Global:dk_replaceAll() {
	dk_debugFunc 3 4;

	# str 			= $args[0];
	# searchValue 	= $args[1];
	# newValue 		= $args[2];
	
	${global:dk_replaceAll} = $args[0] -replace $args[1], $args[2];
	
	if($args[3] -AND ${dk_replaceAll}) {
		dk_call dk_set $args[3] ${dk_replaceAll};
	} else {
		return ${dk_replaceAll};
	}
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	### Result as global variable
	dk_call dk_echo
	dk_call dk_replaceAll ":ogs :on't :ance" ":" "D";
	dk_call dk_echo "dk_replaceAll = ${dk_replaceAll}";
	
	### Result as return value
	dk_call dk_echo
	$resultA = dk_call dk_replaceAll "AZC AZC Zannana Zread" "Z" "B";
	dk_call dk_echo "resultA = ${resultA}";
	dk_call dk_echo "dk_replaceAll = ${dk_replaceAll}";
	
	### Result as parameter
	dk_call dk_echo
	dk_call dk_replaceAll "0pples 0re 0mazing" "0" "A" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_replaceAll = ${dk_replaceAll}";
}
