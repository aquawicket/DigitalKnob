if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Target_Type_ps1){ $dk_Target_Type_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_Target_Type()
#
#
function Global:dk_Target_Type() {
	dk_debugFunc 0;

	dk_call dk_echo "\n";
	dk_call dk_echo "${Target_App} ${Target_Tuple} ${Target_Type}"
	dk_call dk_echo	
	dk_call dk_echo " 1) Release" 
	dk_call dk_echo " 2) Debug"
	dk_call dk_echo " 3) All"
	dk_call dk_echo " 4) Clear Screen"
	dk_call dk_echo " 5) Go Back"
	dk_call dk_echo " 6) Exit"
	dk_call dk_echo "\n";
	
	dk_call dk_keyboardInput;
	    if(${dk_keyboardInput} -eq "1"){ ${Target_Type} = "Release" }
	elseif(${dk_keyboardInput} -eq "2"){ ${Target_Type} = "Debug" }
	elseif(${dk_keyboardInput} -eq "3"){ ${Target_Type} = "All" }
	elseif(${dk_keyboardInput} -eq "4"){ dk_call dk_clearScreen }
	elseif(${dk_keyboardInput} -eq "5"){ dk_call dk_unset Target_Type }
	elseif(${dk_keyboardInput} -eq "6"){ dk_call dk_exit 0 }
	else {
		dk_call dk_unset Target_Type; 
		dk_call dk_echo "${dk_keyboardInput}: invalid selection, please try again";
		return;
	}
	
	${global:Target_Type} = ${Target_Type};
	${global:$(Target_Type)} = 1;
	
	${env:Target_Type} = ${Target_Type};
	${env:$(Target_Type)} = 1;
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_Target_Type
}
