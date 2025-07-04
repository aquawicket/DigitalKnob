if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_Target_App_ps1){ $dk_Target_App_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_Target_App()
#
#
function Global:dk_Target_App() {
	dk_debugFunc 0;
	
	dk_call dk_echo "\n";
	dk_call dk_echo "${Target_App} ${Target_Tuple} ${Target_Type}\n";
	
	dk_call dk_echo "\n";
    dk_call dk_echo " 1) HelloWorld\n";
    dk_call dk_echo " 2) DKCore\n";
    dk_call dk_echo " 3) DKJavascript\n";
    dk_call dk_echo " 4) DKSDL\n";
    dk_call dk_echo " 5) DKSDLRml\n";
    dk_call dk_echo " 6) DKDomTest\n";
    dk_call dk_echo " 7) DKTestAll\n";
    dk_call dk_echo " 8) Enter Manually\n";
    dk_call dk_echo " 9) Clear Screen\n";
    dk_call dk_echo "10) Go Back\n";
    dk_call dk_echo "11) Reload\n";
	dk_call dk_echo "12) Exit\n";
    dk_call dk_echo "\n";
	
	dk_call dk_keyboardInput;
	    if($dk_keyboardInput -eq  "1"){ ${global:Target_App} = "HelloWorld"; }
	elseif($dk_keyboardInput -eq  "2"){ ${global:Target_App} = "DKCore"; }
	elseif($dk_keyboardInput -eq  "3"){ ${global:Target_App} = "DKJavascript"; }
	elseif($dk_keyboardInput -eq  "4"){ ${global:Target_App} = "DKSDL"; }
	elseif($dk_keyboardInput -eq  "5"){ ${global:Target_App} = "DKSDLRml"; }
	elseif($dk_keyboardInput -eq  "6"){ ${global:Target_App} = "DKDomTest"; }
	elseif($dk_keyboardInput -eq  "7"){ ${global:Target_App} = "DKTestAll"; }
	elseif($dk_keyboardInput -eq  "8"){ dk_call dk_enterManually; }
	elseif($dk_keyboardInput -eq  "9"){ dk_call dk_clearScreen; }
	elseif($dk_keyboardInput -eq "10"){ dk_call dk_unset UPDATE; }
	elseif($dk_keyboardInput -eq "11"){ dk_call dk_reload; }
	elseif($dk_keyboardInput -eq "12"){ dk_call dk_exit 0; }
	else{ dk_call dk_warning "invalid selection"; }
	
	${env:Target_App} = ${Target_App};
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_Target_App;
}
