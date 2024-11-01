#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_pickApp()
#
#
dk_pickApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "${APP-} ${triple-} ${TYPE-}"
	
	dk_call dk_echo
    dk_call dk_echo " 1) HelloWorld"
    dk_call dk_echo " 2) DKCore"
    dk_call dk_echo " 3) DKJavascript"
    dk_call dk_echo " 4) DKSDL"
    dk_call dk_echo " 5) DKSDLRml"
    dk_call dk_echo " 6) DKDomTest"
    dk_call dk_echo " 7) DKTestAll"
    dk_call dk_echo " 8) Enter Manually"
    dk_call dk_echo " 9) Clear Screen"
    dk_call dk_echo "10) Go Back"
    dk_call dk_echo "11) Reload"
	dk_call dk_echo "12) Exit"
    dk_call dk_echo
	
	#dk_call dk_keyboardInput choice
	dk_call dk_keyboardInputTimeout choice 23 60 
	
	if [ "${choice}" = "1" ]; then
		APP="HelloWorld"
	elif [ "${choice}" = "2" ]; then
		APP="DKCore"
	elif [ "${choice}" = "3" ]; then
		APP="DKJavascript"
	elif [ "${choice}" = "4" ]; then
		APP="DKSDL"
	elif [ "${choice}" = "5" ]; then
		APP="DKSDLRml"
	elif [ "${choice}" = "6" ]; then
		APP="DKDomTest"
	elif [ "${choice}" = "7" ]; then
		APP="DKTestAll"
	elif [ "${choice}" = "8" ]; then
		dk_call dk_enterManually
	elif [ "${choice}" = "9" ]; then
		dk_call dk_clearScreen
	elif [ "${choice}" = "10" ]; then
		unset UPDATE
	elif [ "${choice}" = "11" ]; then
		dk_call dk_reload
	elif [ "${choice}" = "12" ]; then
		dk_call dk_exit 0
	else
		dk_call dk_warning "invalid selection"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickApp
}
