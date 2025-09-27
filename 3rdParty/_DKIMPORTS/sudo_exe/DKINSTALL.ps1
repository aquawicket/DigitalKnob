if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/../../DKPowershell/functions/DK.ps1; }
if(!$sudo_DKINSTALL_ps1){ $sudo_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;

	if(!${sudo_exe}){ ${sudo_exe} = "sudo.exe"; }

	### Test if already valid
	if(Test-Path "${sudo_exe}"){ 
		if(dk_call "${sudo_exe}" --version){ return; }
	}


	if(!(Test-Path "${sudo_exe}")){ ${sudo_exe} = "C:/Windows/System32/sudo.exe"; }
	if(!(Test-Path "${sudo_exe}")){ ${sudo_exe} = $(dk_call dk_findProgram sudo_exe "sudo.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${sudo_exe}")){ dk_call dk_error "sudo_exe:${sudo_exe} not found"; return;}

	### Test command
	if(!(dk_call "${sudo_exe}" --version)){ dk_call dk_error "sudo_exe:${sudo_exe} failed to run"; return;}
	
	
	###### output ######
	${global:sudo_exe} = ${sudo_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${sudo_exe};
#	#} else {
		return ${sudo_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_validate sudo_exe "dk_call dk_depend sudo_exe";
	dk_call dk_echo "sudo_exe = ${sudo_exe}";
	
	dk_call dk_validate sudo_exe "dk_call dk_depend sudo_exe";
	dk_call dk_echo "sudo_exe = ${sudo_exe}";
}
