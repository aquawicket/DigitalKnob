if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_set_ps1){ $dk_set_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_set(variable value)
#
#
function Global:dk_set() {
	dk_debugFunc 0 2;
	
	$var = $($args[0]);
	${AllButFirstArgs} = ${args} | Select-Object -Skip 1;
	$val = ${AllButFirstArgs};
	Write-Host "'${var}' '${val}'"
	
	Set-Variable -Name ${$(var)} -Value ${$(val)} -Scope Global
	Set-Item env:${var} ${val};
}















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_set myVar "value assigned with dk_set"	
	dk_call dk_info "myVar = ${myVar}"
	dk_call dk_info "env:myVar = ${env:myVar}"
}
