#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_target_app()
#
#
dk_target_app() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_echo "${target_app-} ${Target_Tuple-} ${target_type-}"
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
		target_app="HelloWorld"
	elif [ "${choice}" = "2" ]; then
		target_app="DKPreprocessor"
	elif [ "${choice}" = "3" ]; then
		target_app="DKCore"
	elif [ "${choice}" = "4" ]; then
		target_app="DKJavascript"
	elif [ "${choice}" = "5" ]; then
		target_app="DKSDL"
	elif [ "${choice}" = "6" ]; then
		target_app="DKSDLRml"
	elif [ "${choice}" = "7" ]; then
		target_app="DKDomTest"
	elif [ "${choice}" = "8" ]; then
		target_app="DKTestAll"
	elif [ "${choice}" = "9" ]; then
		dk_call dk_enterManually
	elif [ "${choice}" = "10" ]; then
		dk_call dk_clearScreen
	elif [ "${choice}" = "11" ]; then
		unset UPDATE
		return 1
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
	
	dk_call dk_target_app
}
