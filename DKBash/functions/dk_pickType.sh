#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_pickType()
#
#
dk_pickType() {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE-}"
	dk_echo	
    dk_echo " 1) Debug"
	dk_echo " 2) Release"
	dk_echo " 3) All"
	dk_echo " 4) Clear Screen"
	dk_echo " 5) Go Back"
	dk_echo " 6) Exit"
	dk_echo
	
	read input
	if [ "${input}" = "1" ]; then
		TYPE="Debug"
	elif [ "${input}" = "2" ]; then
		TYPE="Release"
	elif [ "${input}" = "3" ]; then
		TYPE="All"
	elif [ "${input}" = "4" ]; then
		dk_clearScreen
	elif [ "${input}" = "5" ]; then
		TARGET_OS=
	elif [ "${input}" = "6" ]; then
		dk_exit 0
	else
		dk_warning "invalid selection"
	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_pickType
}