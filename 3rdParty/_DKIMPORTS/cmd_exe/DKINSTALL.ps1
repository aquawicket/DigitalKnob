if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/../../DKPowershell/functions/DK.ps1; }
if(!$reg_DKINSTALL_ps1){ $reg_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;

	if(!${reg_exe}){ ${reg_exe} = "reg.exe"; }

	### Test if already valid
	if(Test-Path "${reg_exe}"){ 
		if(dk_call "${reg_exe}" /?){ return; }
	}


	if(!(Test-Path "${reg_exe}")){ ${reg_exe} = "C:/Windows/System32/reg.exe"; }
	if(!(Test-Path "${reg_exe}")){ ${reg_exe} = $(dk_call dk_findProgram reg_exe "reg.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${reg_exe}")){ dk_call dk_error "reg_exe:${reg_exe} not found"; return; }

	### Test command
	if(!(dk_call "${reg_exe}" /?)){ dk_call dk_error "reg_exe:${reg_exe} failed to run"; return; }
	
	###### output ######
	${global:reg_exe} = ${reg_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${reg_exe};
#	#} else {
		return ${reg_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_validate reg_exe "dk_call dk_depend reg_exe";
	dk_call dk_echo "reg_exe = ${reg_exe}";
	
	dk_call dk_validate reg_exe "dk_call dk_depend reg_exe";
	dk_call dk_echo "reg_exe = ${reg_exe}";
}
