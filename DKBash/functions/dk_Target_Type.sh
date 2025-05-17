#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_Target_Type()
#
#
dk_Target_Type() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_echo "${Target_App-} ${Target_Tuple-} ${Target_Type-}"
	dk_echo	
    dk_echo " 1) Debug"
	dk_echo " 2) Release"
	dk_echo " 3) All"
	dk_echo " 4) Clear Screen"
	dk_echo " 5) Go Back"
	dk_echo " 6) Exit"
	dk_echo
	
	#dk_call dk_keyboardInput choice
	dk_call dk_keyboardInputTimeout choice 1 60 
	
	if [ "${choice}" = "1" ]; then
		Target_Type="Debug"
	elif [ "${choice}" = "2" ]; then
		Target_Type="Release"
	elif [ "${choice}" = "3" ]; then
		Target_Type="All"
	elif [ "${choice}" = "4" ]; then
		dk_call dk_clearScreen
	elif [ "${choice}" = "5" ]; then
		unset Target_Tuple
		return 1
	elif [ "${choice}" = "6" ]; then
		dk_call dk_exit 0
	else
		dk_call dk_warning "invalid selection"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_Target_Type
}
