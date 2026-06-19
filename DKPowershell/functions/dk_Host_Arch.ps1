if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . '${PSScriptRoot}/DK.ps1'; }
if(!$dk_Host_Arch_ps1){ $dk_Host_Arch_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Host_Arch()
#
#    Get or Set the architecture of the Host System
#
function Global:dk_Host_Arch() {
	dk_debugFunc 0 99;

	###### SET ######
	if($($args[0])){
		${global:Host_Arch} = $($args[0]);
		${env:Host_Arch} = $($args[0]);
	
	###### GET ######	
	} else {
		if("${env:PROCESSOR_ARCHITECTURE}" -eq "x86")	{	${global:Host_Arch} = "X86";	${env:Host_Arch} = "X86";		}
		if("${env:PROCESSOR_ARCHITECTURE}" -eq "AMD64")	{	${global:Host_Arch} = "X86_64";	${env:Host_Arch} = "X86_64";	}
		if("${env:PROCESSOR_ARCHITECTURE}" -eq "IA64")	{	${global:Host_Arch} = "X86_64";	${env:Host_Arch} = "X86_64";	}
		if("${env:PROCESSOR_ARCHITECTURE}" -eq "EM64T")	{	${global:Host_Arch} = "X86_64";	${env:Host_Arch} = "X86_64";	}
		if("${env:PROCESSOR_ARCHITECTURE}" -eq "ARM64")	{	${global:Host_Arch} = "Arm64";	${env:Host_Arch} = "Arm64";		}
	}

	###### FINALIZE ######
	${global:$(Host_Arch)_Host} = 1;
	${env:$(Host_Arch)_Host} = 1;
	
	return ${env:Host_Arch}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
	dk_call dk_echo
	dk_call dk_echo "Test Getting Host_Arch . . .\n";
    dk_call dk_Host_Arch
	dk_call dk_echo "Host_Arch = ${Host_Arch}"
	dk_call dk_echo "env:Host_Arch = ${env:Host_Arch}"
	dk_call dk_echo "${Host_Arch}_Host = ${$(Host_Arch)_Host}"
	dk_call dk_echo "env:${Host_Arch}_Host = ${env:$(Host_Arch)_Host}"
    dk_call dk_echo "dk_Host_Arch = '$(dk_call dk_Host_Arch)'\n";
	
	###### SET ######
	dk_call dk_echo
	dk_call dk_echo "Test Setting Host_Arch . . .\n";
	dk_call dk_Host_Arch "I686"
	dk_call dk_echo "Host_Arch = ${Host_Arch}"
	dk_call dk_echo "env:Host_Arch = ${env:Host_Arch}"
	dk_call dk_echo "${Host_Arch}_Host = ${$(Host_Arch)_Host}"
	dk_call dk_echo "env:${Host_Arch}_Host = ${env:$(Host_Arch)_Host}"
	dk_call dk_echo "dk_Host_Arch = '$(dk_call dk_Host_Arch I686)'\n";
}
