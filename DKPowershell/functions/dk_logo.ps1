if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_logo){ $dk_logo = 1 } else{ return }

################################################################################
# dk_logo()
#
function Global:dk_logo (){
	dk_debugFunc


	dk_echo "${lblue}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______        "
	dk_echo "${lblue}   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]       "
	dk_echo "${blue}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]  ${clr}"
	dk_echo ""
}




function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_logo
}
