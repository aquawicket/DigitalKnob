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
	
	$input = Read-Host
	    if($input -eq  "1"){ $global:Target_App = "HelloWorld" }
	elseif($input -eq  "2"){ $global:Target_App = "DKCore" }
	elseif($input -eq  "3"){ $global:Target_App = "DKJavascript" }
	elseif($input -eq  "4"){ $global:Target_App = "DKSDL" }
	elseif($input -eq  "5"){ $global:Target_App = "DKSDLRml" }
	elseif($input -eq  "6"){ $global:Target_App = "DKDomTest" }
	elseif($input -eq  "7"){ $global:Target_App = "DKTestAll" }
	elseif($input -eq  "8"){ dk_call dk_enterManually }
	elseif($input -eq  "9"){ dk_call dk_clearScreen }
	elseif($input -eq "10"){ dk_call dk_unset UPDATE }
	elseif($input -eq "11"){ dk_call dk_reload }
	elseif($input -eq "12"){ dk_call dk_exit 0 }
	else{ dk_call dk_warning "invalid selection" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_Target_App;
}
