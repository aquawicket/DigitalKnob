if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_logo){ $dk_logo = 1 } else{ return }

################################################################################
# dk_logo()
#
function Global:dk_logo() {
	dk_debugFunc 0


	dk_echo "${lblue}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______  "
	dk_echo "${lblue}   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____] "
	dk_echo "${blue}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]  "
	dk_echo "${green}                                                             __     __                   "
	dk_echo "${green}                                                            |  \|_/|__)_     _ _ _|_  _||" 
    dk_echo "${green}                                                            |__/| \|  (_)\//(-| _)| )(-||"
	dk_echo "${clr}"
}




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc 0
	
	dk_logo
}
