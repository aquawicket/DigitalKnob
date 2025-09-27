if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/../../DKPowershell/functions/DK.ps1; }
if(!$wslpath_DKINSTALL_ps1){ $wslpath_DKINSTALL_ps1 = 1; } else{ return; } #include guard

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;

	if(!${wslpath_exe}){ ${wslpath_exe} = "wslpath.exe"; }

	### Test if already valid
	if(Test-Path "${wslpath_exe}"){ 
		if(dk_call "${wslpath_exe}" --status){ return; }
	}


	if(!(Test-Path "${wslpath_exe}")){ ${wslpath_exe} = "C:/Windows/System32/wslpath.exe"; }
	if(!(Test-Path "${wslpath_exe}")){ ${wslpath_exe} = $(dk_call dk_findProgram wslpath_exe "wslpath.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${wslpath_exe}")){ dk_call dk_error "wslpath_exe:${wslpath_exe} not found"; return;}

	### Test command
	if(!(dk_call "${wslpath_exe}" --status)){ dk_call dk_error "wslpath_exe:${wslpath_exe} failed to run"; return;}
	
	
	###### output ######
	${global:wslpath_exe} = ${wslpath_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${wslpath_exe};
#	#} else {
		return ${wslpath_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
    dk_call dk_validate wslpath_exe "dk_call dk_depend wslpath_exe";
	dk_call dk_echo "wslpath_exe = ${wslpath_exe}";
	
	dk_call dk_validate wslpath_exe "dk_call dk_depend wslpath_exe";
	dk_call dk_echo "wslpath_exe = ${wslpath_exe}";
}
