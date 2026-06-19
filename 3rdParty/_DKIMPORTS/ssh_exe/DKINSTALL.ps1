if(!(${env:DKINIT_ps1})) {
	if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; exit $? } else { . ${PSScriptRoot}/../../../DKPowershell/functions/DK.ps1; exit $? }
	#if(!$ssh_DKINSTALL_ps1){ $ssh_DKINSTALL_ps1 = 1; } else{ return; } #include guard
	exit $?;
}

####################################################################
# DKINSTALL()
#
#
function Global:DKINSTALL() {
	dk_debugFunc 0 1;
	
	### Test if already valid
	if(${ssh_exe}) { 
		if(&cmd.exe /c "${ssh_exe}" -V) {
			&{cmd.exe /c exit 0};
			return 0;
		} else {
			&{cmd.exe /c exit 0};
		}
	} else {
		&{cmd.exe /c exit 0};
	}
	
	if(!(${ssh_exe})){ 
		${ssh_exe} = "C:/Windows/System32/OpenSSH/ssh.exe";
	}	
	if(!(Test-Path "${ssh_exe}")){ ${ssh_exe} = $(dk_call dk_findProgram ssh_exe "ssh.exe"); }
	
	
	### Test exists
	if(!(Test-Path "${ssh_exe}")){ dk_call dk_error "ssh_exe:${ssh_exe} not found"; return;}

	### Test command
	if(&"${ssh_exe}" -V ne 0){ dk_call dk_error "ssh_exe:${ssh_exe} failed to run"; return; }
	
	
	###### return ######
	${global:ssh_exe} = ${ssh_exe};
#	#if($args[1]) {
#	#	dk_call dk_set $args[1] ${ssh_exe};
#	#} else {
		return ${ssh_exe};
#	#}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

    dk_call dk_validate ssh_exe "dk_call dk_depend ssh_exe";
	dk_call dk_echo "ssh_exe = ${ssh_exe}";
	
	dk_call dk_validate ssh_exe "dk_call dk_depend ssh_exe";
	dk_call dk_echo "ssh_exe = ${ssh_exe}";
}
