if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_DKCACHE_DIR_ps1){ $dk_DKCACHE_DIR_ps1 = 1 } else{ return } #include guard

####################################################################
# dk_DKCACHE_DIR()
#
#
function Global:dk_DKCACHE_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		${env:DKCACHE_DIR} = $($args[0])
	
	############ GET ############
	} else {
		if(!(${env:DKCACHE})){
			${env:DKCACHE}=".dk"
		}
		if(!(${env:DKCACHE_DIR})){
			${env:DKCACHE_DIR} = "$(dk_call dk_DKHOME_DIR)/${env:DKCACHE}" 
		}
	}
	
	############ FINALIZE ############
	if(!(Test-Path ${env:DKCACHE_DIR})){ 
		dk_call dk_mkdir ${env:DKCACHE_DIR}
	}

	dk_call dk_assertPath ${env:DKCACHE_DIR}
	return ${env:DKCACHE_DIR}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKCACHE_DIR . . .";
    dk_call dk_echo "DKCACHE_DIR = '$(dk_call dk_DKCACHE_DIR)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKCACHE_DIR . . .";
	dk_call dk_echo "DKCACHE_DIR = '$(dk_call dk_DKCACHE_DIR 'C:/.dk')'";
}
