if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_DKCACHE_DIR_ps1){ $dk_DKCACHE_DIR_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_DKCACHE_DIR()
#
#
function Global:dk_DKCACHE_DIR() {
    dk_debugFunc 0 1;

	############ SET ############
	if($($args[0])){
		${env:DKCACHE_DIR} = $($args[0]);
	
	############ GET ############
	} else {
		if(!(${env:DKCACHE})){
			${env:DKCACHE}=".dk";
		}
		if(!(${env:DKCACHE_DIR})){
			${env:DKCACHE_DIR} = "$(dk_call dk_DKHOME_DIR)/${env:DKCACHE}";
		}
	}
	
	############ FINALIZE ############
	${env:DKCACHE_DIR} = ${env:DKCACHE_DIR} -replace '\\', '/';
	
	if(!(Test-Path ${env:DKCACHE_DIR})){ 
		dk_call dk_mkdir ${env:DKCACHE_DIR};
	}
	
	return ${env:DKCACHE_DIR};
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0;
   
	###### GET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Getting DKCACHE_DIR . . .\n";
	dk_call dk_DKCACHE_DIR
	dk_call dk_echo "env:DKCACHE_DIR = ${env:DKCACHE_DIR}";
    dk_call dk_echo "dk_DKCACHE_DIR = '$(dk_call dk_DKCACHE_DIR)'\n";
	
	###### SET ######
	dk_call dk_echo "\n";
	dk_call dk_echo "Test Setting DKCACHE_DIR . . .\n";
	dk_call dk_DKCACHE_DIR "C:/.dk"
	dk_call dk_echo "env:DKCACHE_DIR = ${env:DKCACHE_DIR}"
	dk_call dk_echo "dk_DKCACHE_DIR = '$(dk_call dk_DKCACHE_DIR 'C:/.dk')'\n";
}
