#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_pickApp()
#
#
dk_pickApp() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_echo "${APP-} ${triple-} ${TYPE-}"
	dk_echo
    dk_echo " 1) HelloWorld"
	dk_echo " 2) DKPreprocessor"
    dk_echo " 3) DKCore"
    dk_echo " 4) DKJavascript"
    dk_echo " 5) DKSDL"
    dk_echo " 6) DKSDLRml"
    dk_echo " 7) DKDomTest"
    dk_echo " 8) DKTestAll"
    dk_echo " 9) Enter Manually"
    dk_echo "10) Clear Screen"
    dk_echo "11) Go Back"
    dk_echo "12) Reload"
	dk_echo "13) Exit"
    dk_echo
	
	#dk_call dk_keyboardInput choice
	dk_call dk_keyboardInputTimeout choice 23 60 
	
	if [ "${choice}" = "1" ]; then
		APP="HelloWorld"
	elif [ "${choice}" = "2" ]; then
		APP="DKPreprocessor"
	elif [ "${choice}" = "3" ]; then
		APP="DKCore"
	elif [ "${choice}" = "4" ]; then
		APP="DKJavascript"
	elif [ "${choice}" = "5" ]; then
		APP="DKSDL"
	elif [ "${choice}" = "6" ]; then
		APP="DKSDLRml"
	elif [ "${choice}" = "7" ]; then
		APP="DKDomTest"
	elif [ "${choice}" = "8" ]; then
		APP="DKTestAll"
	elif [ "${choice}" = "9" ]; then
		dk_call dk_enterManually
	elif [ "${choice}" = "10" ]; then
		dk_call dk_clearScreen
	elif [ "${choice}" = "11" ]; then
		unset UPDATE
	elif [ "${choice}" = "12" ]; then
		dk_call dk_reload
	elif [ "${choice}" = "13" ]; then
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
