if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKTOOLS_DIR_ps1){ $dk_DKTOOLS_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKTOOLS_DIR()
#
#
function Global:dk_DKTOOLS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){
		${env:DKTOOLS_DIR} = $($args[0])
	
	############ GET ############
	} else {
		if(!(${env:DKTOOLS})){
			${env:DKTOOLS}="DKTools"
		}
		if(!(${env:DKTOOLS_DIR})){
			${env:DKTOOLS_DIR} = "$(dk_call dk_DIGITALKNOB_DIR)/${env:DKTOOLS}" 
		}
	}
	
	############ FINALIZE ############
	${env:DKTOOLS_DIR} = ${env:DKTOOLS_DIR} -replace '\\', '/';
	
	#if(!(Test-Path ${env:DKTOOLS_DIR})){ 
	#	dk_call dk_mkdir ${env:DKTOOLS_DIR}
	#}
	return ${env:DKTOOLS_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKTOOLS_DIR . . .\n";
	dk_call dk_DKTOOLS_DIR
	dk_call dk_echo "env:DKTOOLS_DIR = ${env:DKTOOLS_DIR}";
    dk_call dk_echo "dk_DKTOOLS_DIR = '$(dk_call dk_DKTOOLS_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DKTOOLS_DIR . . .\n";
	dk_call dk_DKTOOLS_DIR "C:/.dk"
	dk_call dk_echo "env:DKTOOLS_DIR = ${env:DKTOOLS_DIR}"
	dk_call dk_echo "dk_DKTOOLS_DIR = '$(dk_call dk_DKTOOLS_DIR 'C:/.dk')'\n";
}
