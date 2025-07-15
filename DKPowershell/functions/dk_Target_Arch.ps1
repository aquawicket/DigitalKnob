if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Target_Arch_ps1){ $dk_Target_Arch_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Target_Arch()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_Target_Arch() {
	dk_debugFunc 0 1;

	###### SET ######
	if($($args[0])) {
		${Target_Arch} = $($args[0]);
	
	###### GET ######	
	} else {
		dk_call dk_echo;
		#if not defined Target_Arch_Cache (dk_call Target_Arch_Cache)
		if(${Target_Arch_Cache}){
			dk_call dk_echo " 0) ${Target_Arch_Cache}";
			dk_call dk_echo;
		}	
		if(!(${Host_Arch})) { dk_call dk_Host_Arch; }
		dk_call dk_echo " 1) ${Host_Arch}";
		dk_call dk_echo " 2) Arm32";
		dk_call dk_echo " 3) Arm64";
		dk_call dk_echo " 4) X86";
		dk_call dk_echo " 5) X86_64";
		dk_call dk_echo " 6) Go Back";
		dk_call dk_echo " 7) Exit";
		dk_call dk_echo;

		dk_call dk_keyboardInput;
		    if(${dk_keyboardInput} -eq "0") { ${Target_Arch} = "${Target_Arch_Cache}"; }
		elseif(${dk_keyboardInput} -eq "1") { ${Target_Arch} = "${Host_Arch}"; }
		elseif(${dk_keyboardInput} -eq "2") { ${Target_Arch} = "Arm32"; }
		elseif(${dk_keyboardInput} -eq "3") { ${Target_Arch} = "Arm64"; }
		elseif(${dk_keyboardInput} -eq "4") { ${Target_Arch} = "X86"; }
		elseif(${dk_keyboardInput} -eq "5") { ${Target_Arch} = "X86_64"; }
		elseif(${dk_keyboardInput} -eq "6") { dk_call dk_unset Target_Os; return; }
		elseif(${dk_keyboardInput} -eq "7")	{ dk_call dk_exit 0; }
		else {
			dk_call dk_unset Target_Arch; 
			dk_call dk_echo "${dk_keyboardInput}: invalid selection, please try again";
			return;
		}
	}
	
	${$(Target_Arch)} = 1;
	
	${global:Target_Arch} = ${Target_Arch};
	${global:$(Target_Arch)} = 1;
	
	${env:Target_Arch} = ${Target_Arch};
	${env:$(Target_Arch)} = 1;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Arch
	dk_call dk_echo "Target_Arch = ${Target_Arch}";
	dk_call dk_echo "${Target_Arch} = ${$(Target_Arch)}";
	
	###### SET ######
	dk_call dk_Target_Arch "I686"
	dk_call dk_echo "Target_Arch = ${Target_Arch}";
	dk_call dk_echo "${Target_Arch} = ${$(Target_Arch)}";
}
