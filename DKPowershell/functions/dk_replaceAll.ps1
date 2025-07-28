if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_replaceAll_ps1){ $dk_replaceAll_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_replaceAll(input, searchValue, newValue) -> rtn_var
#
#
function Global:dk_replaceAll() {
	dk_debugFunc 3 4;

	${str} = $($args[0]);
	${searchValue} = $($args[1]);
	${newValue} = $($args[2]);
	
	${replaceAll} = ${str} -replace ${searchValue}, ${newValue};
	

	if($($args[3])) {
		Set-Variable -Name $($args[3]) -Value ${replaceAll} -Scope Global;
		#Write-Host "dk_basename() $($args[1])  = ${basename}";
	}
	return ${replaceAll};
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	${string_var}="AZC AZC Zannana Zread";
	dk_call dk_info "string before:  ${string_var}";
	
	${string_var} = dk_call dk_replaceAll $string_var "Z" "B";
	dk_call dk_info "string after:  ${string_var}";
}
