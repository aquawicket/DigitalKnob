if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/../../DKPowershell/functions/DK.ps1; }
if(!$wsl_DKINSTALL_ps1){ $wsl_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;

	if(!${wsl_exe}){ ${wsl_exe} = "wsl.exe"; }

	### Test if already valid
	if(Test-Path "${wsl_exe}"){ 
		if(dk_call "${wsl_exe}" --status){ return; }
	}


	if(!(Test-Path "${wsl_exe}")){ ${wsl_exe} = "C:/Windows/System32/wsl.exe"; }
	if(!(Test-Path "${wsl_exe}")){ ${wsl_exe} = $(dk_call dk_findProgram wsl_exe "wsl.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${wsl_exe}")){ dk_call dk_error "wsl_exe:${wsl_exe} not found"; return;}

	### Test command
	if(!(dk_call "${wsl_exe}" --status)){ dk_call dk_error "wsl_exe:${wsl_exe} failed to run"; return;}
	
	
	###### output ######
	${global:wsl_exe} = ${wsl_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${wsl_exe};
#	#} else {
		return ${wsl_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_validate wsl_exe "dk_call dk_depend wsl_exe";
	dk_call dk_echo "wsl_exe = ${wsl_exe}";
	
	dk_call dk_validate wsl_exe "dk_call dk_depend wsl_exe";
	dk_call dk_echo "wsl_exe = ${wsl_exe}";
}
