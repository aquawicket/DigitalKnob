if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DIGITALKNOB_DIR_ps1){ $dk_DIGITALKNOB_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function Global:dk_DIGITALKNOB_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if($($args[0])){  
		${env:DIGITALKNOB_DIR} = $($args[0])
	
	############ GET ############
	} else {
		if(!(${env:DIGITALKNOB})){
			${env:DIGITALKNOB}="DigitalKnob"
		}
		if(!(${env:DIGITALKNOB_DIR})){
			${env:DIGITALKNOB_DIR}="$(dk_call dk_DKHOME_DIR)/${env:DIGITALKNOB}"
		}
	}
	
	############ FINALIZE ############
#	if(!(Test-Path ${env:DIGITALKNOB_DIR})){ 
#		dk_call dk_mkdir "${env:DIGITALKNOB_DIR}" 
#	}

#	dk_call dk_assertPath ${env:DIGITALKNOB_DIR}
	return ${env:DIGITALKNOB_DIR}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DIGITALKNOB_DIR . . .\n";
    dk_call dk_echo "DIGITALKNOB_DIR = '$(dk_call dk_DIGITALKNOB_DIR)'\n";
	
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DIGITALKNOB_DIR . . .\n";
	dk_call dk_echo "DIGITALKNOB_DIR = '$(dk_call dk_DIGITALKNOB_DIR 'C:/Digital Knob')'\n";
}
