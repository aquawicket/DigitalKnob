if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!${$PSCommandPath}){ ${$PSCommandPath} = 1 } else{ return } #include guard

####################################################################
# dk_DKIMPORTS_DIR()
#
#
function Global:dk_DKIMPORTS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if($($args[0])){  
		$global:DKIMPORTS_DIR = "$($args[0])" 
		return 0
	}
	
	############ GET ############
	dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR" 
	$global:DKIMPORTS_DIR = "${DK3RDPARTY_DIR}/_DKIMPORTS" 
	
	if(!(Test-Path $DKIMPORTS_DIR)){ 
		dk_call dk_makeDirectory "${DKIMPORTS_DIR}" 
	}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKIMPORTS_DIR . . ."
	dk_call dk_DKIMPORTS_DIR
	dk_call dk_printVar DKIMPORTS_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKIMPORTS_DIR . . ."
	dk_call dk_DKIMPORTS_DIR "C:/DK/_DKIMPORTS"
	dk_call dk_printVar DKIMPORTS_DIR 
}
