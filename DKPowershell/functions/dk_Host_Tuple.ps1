if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Host_Tuple_ps1){ $dk_Host_Tuple_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Host_Tuple()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_Host_Tuple() {
	dk_debugFunc 0 99;

	###### SET ######
	if($($args[0])){
		${global:Host_Tuple} = $($args[0]);
	} 
	
	###### GET ######	
	else {
		if(!${Host_Os})		{	dk_call dk_Host_Os;		}
		if(!${Host_Arch})	{	dk_call dk_Host_Arch;	}
		${global:Host_Tuple} = "${Host_Os}_${Host_Arch}";
	}
	
	###### FINALIZE ######
	New-Variable -Name "${Host_Tuple}" -Value 1 -Force;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Host_Tuple
	dk_call dk_echo "Host_Tuple = ${Host_Tuple}"
	dk_call dk_echo "${Host_Tuple}_Host =  ${$(Host_Tuple)_Host}"
	
	###### SET ######
	dk_call dk_Host_Tuple "Linux_I686"
	dk_call dk_echo "Host_Tuple = ${Host_Tuple}"
	dk_call dk_echo "${Host_Tuple}_Host =  ${$(Host_Tuple)_Host}"
}
