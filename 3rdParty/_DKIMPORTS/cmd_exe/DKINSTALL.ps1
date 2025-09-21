if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/../../DKPowershell/functions/DK.ps1; }
if(!$cmd_DKINSTALL_ps1){ $cmd_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;

	if(!${cmd_exe}){ ${cmd_exe} = "cmd.exe"; }

	### Test if already valid
	if(Test-Path "${cmd_exe}"){ 
		if(dk_call "${cmd_exe}" /c ver){ return; }
	}


	if(!(Test-Path "${cmd_exe}")){ ${cmd_exe} = "C:/Windows/System32/cmd.exe"; }
	if(!(Test-Path "${cmd_exe}")){ ${cmd_exe} = $(dk_call dk_findProgram cmd_exe "cmd.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${cmd_exe}")){ dk_call dk_error "cmd_exe:${cmd_exe} not found"; return; }

	### Test command
	if(!(dk_call "${cmd_exe}" /c ver)){ dk_call dk_error "cmd_exe:${cmd_exe} failed to run"; return; }
	
	###### output ######
	${global:cmd_exe} = ${cmd_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${cmd_exe};
#	#} else {
		return ${cmd_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_validate cmd_exe "dk_call dk_depend cmd_exe";
	dk_call dk_echo "cmd_exe = ${cmd_exe}";
	
	dk_call dk_validate cmd_exe "dk_call dk_depend cmd_exe";
	dk_call dk_echo "cmd_exe = ${cmd_exe}";
}
