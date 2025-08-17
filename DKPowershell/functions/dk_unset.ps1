if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_unset_ps1){ $dk_unset_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_unset(variable)
#
#
function Global:dk_unset() {
	dk_debugFunc 1;

	${var}=$args[0];
	
	if(Test-Path "variable:${var}"){ 
		Remove-Variable -Name "${var}" -Scope Global -ErrorAction SilentlyContinue;
		return; 
	}
	
	#if(!(Test-Path variable:$variable)){ return }
	#Remove-Variable $variable -Scope Local
	
	#if(!(Test-Path variable:$variable)){ return }
	#Remove-Variable $variable -Scope Script
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() {
	dk_debugFunc 0;
	
	$global:myVar = "initial value assigned before dk_unset"
	dk_call dk_echo "myVar = ${myVar}"
	dk_call dk_unset myVar
	dk_call dk_echo "myVar = ${myVar}"
}
