#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_pickType()
#
#
dk_pickType() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "${APP} ${TARGET_OS} ${TYPE-}"
	dk_call dk_echo	
    dk_call dk_echo " 1) Debug"
	dk_call dk_echo " 2) Release"
	dk_call dk_echo " 3) All"
	dk_call dk_echo " 4) Clear Screen"
	dk_call dk_echo " 5) Go Back"
	dk_call dk_echo " 6) Exit"
	dk_call dk_echo
	
	dk_call dk_keyboardInput input
	if [ "${input}" = "1" ]; then
		TYPE="Debug"
	elif [ "${input}" = "2" ]; then
		TYPE="Release"
	elif [ "${input}" = "3" ]; then
		TYPE="All"
	elif [ "${input}" = "4" ]; then
		dk_call dk_clearScreen
	elif [ "${input}" = "5" ]; then
		TARGET_OS=
	elif [ "${input}" = "6" ]; then
		dk_call dk_exit 0
	else
		dk_call dk_warning "invalid selection"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickType
}
