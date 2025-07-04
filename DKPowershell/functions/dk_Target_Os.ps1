if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Target_Os_ps1){ $dk_Target_Os_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_Target_Os()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_Target_Os() {
	dk_debugFunc 0 1;

	###### SET ######
	if($($args[0])){
		${Target_Os} = $($args[0]);
	
	###### GET ######	
	} else {
		dk_call dk_echo;
		
		#if(not defined Target_Os_Cache) {dk_call Target_Os_Cache)
		dk_call dk_echo " 0) ${Target_Os_Cache}";
		dk_call dk_echo;
		if(!(${Host_Os})){ dk_call dk_Host_Os; }
		dk_call dk_echo " 1) ${Host_Os}";
		dk_call dk_echo " 2) Android";
		dk_call dk_echo " 3) Cosmopolitan";
		dk_call dk_echo " 4) Emscripten";
		dk_call dk_echo " 5) Ios";
		dk_call dk_echo " 6) Iossim";
		dk_call dk_echo " 7) Linux";
		dk_call dk_echo " 8) Mac";
		dk_call dk_echo " 9) Raspberry";
		dk_call dk_echo "10) Windows";
		dk_call dk_echo "11) Go Back";
		dk_call dk_echo "12) Exit";
		dk_call dk_echo;

		dk_call dk_keyboardInput;
		
		if(${dk_keyboardInput} -eq "0")	{ ${global:Target_Os} = "${Target_Os_Cache}"; }
		if(${dk_keyboardInput} -eq "1")	{ ${global:Target_Os} = "${Host_Os}"; }
		if(${dk_keyboardInput} -eq "2") { ${global:Target_Os} = "Android"; }
		if(${dk_keyboardInput} -eq "3") { ${global:Target_Os} = "Cosmopolitan"; }
		if(${dk_keyboardInput} -eq "4") { ${global:Target_Os} = "Emscripten"; }
		if(${dk_keyboardInput} -eq "5") { ${global:Target_Os} = "Ios"; }
		if(${dk_keyboardInput} -eq "6") { ${global:Target_Os} = "Iossim"; }
		if(${dk_keyboardInput} -eq "7") { ${global:Target_Os} = "Linux"; }
		if(${dk_keyboardInput} -eq "8") { ${global:Target_Os} = "Mac"; }
		if(${dk_keyboardInput} -eq "9") { ${global:Target_Os} = "Raspberry"; }
		if(${dk_keyboardInput} -eq "10"){ ${global:Target_Os} = "Windows"; }
		if(${dk_keyboardInput} -eq "11"){
			dk_call dk_unset Target_App;
			return;
		}
		if(${dk_keyboardInput} -eq "12"){ dk_call dk_exit 0; }
	}
	
	${global:$(Target_Os)} = 1;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;

	###### GET ######
    dk_call dk_Target_Os
	dk_call dk_echo "Target_Os = ${Target_Os}";
	dk_call dk_echo "${Target_Os} = ${$(Target_Os)}"
	
	###### SET ######
	dk_call dk_Target_Os "Windows"
	dk_call dk_echo "Target_Os = ${Target_Os}";
	dk_call dk_echo "${Target_Os} = ${$(Target_Os)}"
}
