if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Target_Tuple_ps1){ $dk_Target_Tuple_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Target_Tuple()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_Target_Tuple() {
	dk_call dk_debugFunc 0 1;

	###### SET ######
	if($($args[0])){
		${Target_Tuple} = $($args[0]);
	
	###### GET ######	
	} 
	elseif(!(${Target_Tuple})){
		dk_call dk_validate Target_Os	"dk_call dk_Target_Os";
		dk_call dk_validate Target_Arch	"dk_call dk_Target_Arch";
		dk_call dk_validate Target_Env	"dk_call dk_Target_Env";
		${Target_Tuple} = "${Target_Os}_${Target_Arch}_${Target_Env}";
	}
	
	${$(Target_Tuple)} = 1;
	
	${global:Target_Tuple} = ${Target_Tuple};
	${global:$(Target_Tuple)} = 1;
	
	${env:Target_Tuple} = ${Target_Tuple};
	${env:$(Target_Tuple)} = 1;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Tuple;
	dk_call dk_printVar Target_Tuple;
	dk_call dk_printVar ${Target_Tuple};
	
	###### SET ######
	dk_call dk_Target_Tuple "Windows_X86_64_Clang";
	dk_call dk_printVar Target_Tuple;
	dk_call dk_printVar ${Target_Tuple};
}
