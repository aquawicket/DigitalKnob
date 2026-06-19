if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_getParameter_ps1){ $dk_getParameter_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_getParameter()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_getParameter() {
	dk_debugFunc 0 99;

	${_NAME_} = ${args}[0];
	${n} = 1;
	foreach(${arg} in ${args}){
		if(${n} -eq 1){ ${n}++; continue; } # skip the first argument
		if(${arg} -ceq ${args}[0]){
			#Write-Host "${arg} = 1";
			Set-Variable -Name ${arg} -Value 1 -Scope 2;
			return;
		}
		$n++;
	}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	DKTESTB abc 123 ABC 456 OPTION1 OPTION2 "option2 value" OPTION3;
}

function Global:DKTESTB() { 
	dk_debugFunc 0 99;

	Write-Host "args = $args";
	dk_call dk_getParameter ABC @args;
	Write-Host "ABC = ${ABC}";
	dk_call dk_getParameter OPTION3 @args;
	Write-Host "OPTION3 = ${OPTION3}";
	dk_call dk_getParameter OPTION_Z @args;
	Write-Host "OPTION_Z = ${OPTION_Z}";
}
