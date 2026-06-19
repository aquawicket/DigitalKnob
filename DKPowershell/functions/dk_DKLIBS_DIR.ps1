if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKLIBS_DIR_ps1){ $dk_DKLIBS_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKLIBS_DIR()
#
#
function Global:dk_DKLIBS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){
		${env:DKLIBS_DIR} = $($args[0])
	
	############ GET ############
	} else {
		if(!(${env:DKLIBS})){
			${env:DKLIBS}="DKLibs"
		}
		if(!(${env:DKLIBS_DIR})){
			${env:DKLIBS_DIR} = "$(dk_call dk_DIGITALKNOB_DIR)/${env:DKLIBS}" 
		}
	}
	
	############ FINALIZE ############
	${env:DKLIBS_DIR} = ${env:DKLIBS_DIR} -replace '\\', '/';
	
	#if(!(Test-Path ${env:DKLIBS_DIR})){ 
	#	dk_call dk_mkdir ${env:DKLIBS_DIR}
	#}
	return ${env:DKLIBS_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKLIBS_DIR . . .\n";
	dk_call dk_DKLIBS_DIR
	dk_call dk_echo "env:DKLIBS_DIR = ${env:DKLIBS_DIR}";
    dk_call dk_echo "dk_DKLIBS_DIR = '$(dk_call dk_DKLIBS_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DKLIBS_DIR . . .\n";
	dk_call dk_DKLIBS_DIR "C:/.dk"
	dk_call dk_echo "env:DKLIBS_DIR = ${env:DKLIBS_DIR}"
	dk_call dk_echo "dk_DKLIBS_DIR = '$(dk_call dk_DKLIBS_DIR 'C:/.dk')'\n";
}
