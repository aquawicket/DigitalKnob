if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Host_Tuple_ps1){ $dk_Host_Tuple_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Host_Tuple()
#
#    Get or Set the OS/Architecture Tuple of the Host System
#
#    @arg1	- arg1 description
#
function Global:dk_Host_Tuple() {
	dk_debugFunc 0 99;

	###### SET ######
	if($($args[0])){
		${global:Host_Tuple} = $($args[0]);
		${env:Host_Tuple} = $($args[0]);
	} 
	
	###### GET ######	
	else {
		if(!${Host_Os})		{	dk_call dk_Host_Os;		}
		if(!${Host_Arch})	{	dk_call dk_Host_Arch;	}
		${global:Host_Tuple} = "${Host_Os}_${Host_Arch}";
		${env:Host_Tuple} = "${Host_Os}_${Host_Arch}";
	}
	
	###### FINALIZE ######
	${global:$(Host_Tuple)_Host} = 1;
	${env:$(Host_Tuple)_Host} = 1;
	
	return ${env:Host_Tuple}
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting Host_Tuple . . .\n";
    dk_call dk_Host_Tuple
	dk_call dk_echo "Host_Tuple = ${Host_Tuple}"
	dk_call dk_echo "env:Host_Tuple = ${env:Host_Tuple}"
	dk_call dk_echo "${Host_Tuple}_Host = ${$(Host_Tuple)_Host}"
	dk_call dk_echo "env:${Host_Tuple}_Host = ${env:$(Host_Tuple)_Host}"
    dk_call dk_echo "dk_Host_Tuple = '$(dk_call dk_Host_Tuple)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting Host_Tuple . . .\n";
	dk_call dk_Host_Tuple "Linux_I686"
	dk_call dk_echo "Host_Tuple = ${Host_Tuple}"
	dk_call dk_echo "env:Host_Tuple = ${env:Host_Tuple}"
	dk_call dk_echo "${Host_Tuple}_Host = ${$(Host_Tuple)_Host}"
	dk_call dk_echo "env:${Host_Tuple}_Host = ${env:$(Host_Tuple)_Host}"
    dk_call dk_echo "dk_Host_Tuple = '$(dk_call dk_Host_Tuple 'Linux_I686')'\n";
}
