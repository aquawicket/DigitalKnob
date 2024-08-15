#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_pickUpdate()
#
#
dk_pickUpdate() {
	dk_debugFunc 0

	dk_call dk_readCache APP TARGET_OS TYPE
	
	dk_call dk_echo
	dk_call dk_gitCheckRemote
	dk_call dk_echo
	
	#dk_call dk_printVar _APP_
	#dk_call dk_printVar _TARGET_OS_ 
	#dk_call dk_printVar _TYPE_
	
	if [ $behind -lt 1 ]; then
		if [ -n "${APP-}" ] && [ -n "${TARGET_OS-}" ] && [ -n "${TYPE-}s" ]; then
			dk_call dk_echo " 0) Repeat cache [$APP - $TARGET_OS - $TYPE]"
		fi
		dk_call dk_echo " 1) Git Update"   
		dk_call dk_echo " 2) Git Commit"
		dk_call dk_echo " 3) Download DigitalKnob"
		dk_call dk_echo " 4) Push assets"
		dk_call dk_echo " 5) Pull assets"
		dk_call dk_echo " 6) Reset All"
		dk_call dk_echo " 7) Remove All"
		dk_call dk_echo " 8) Clear Screen"
		dk_call dk_echo " 9) Clear cmake cache and .tmp files"
		dk_call dk_echo "10) Reload"
		dk_call dk_echo "11) Exit"
		dk_call dk_echo
		dk_call dk_echo " Press Enter To Skip"
	else
		dk_call dk_warning "Your local repository is behind, please git update"
		dk_call dk_echo
		dk_call dk_echo "${red}" 
		if [ -n "${_APP_-}" ] && [ -n "${_TARGET_OS_-}" ] && [ -n "${_TYPE_-}" ]; then
			dk_call dk_echo " 0) Repeat cache [${_APP_} - ${_TARGET_OS_} - ${_TYPE_}]"
		fi
		dk_call dk_echo "${green}"
		dk_call dk_echo " 1) Git Update"
		dk_call dk_echo "${red}"  
		dk_call dk_echo " 2) Git Commit"
		dk_call dk_echo " 3) Download DigitalKnob"
		dk_call dk_echo " 4) Push assets"
		dk_call dk_echo " 5) Pull assets"
		dk_call dk_echo " 6) Reset All"
		dk_call dk_echo " 7) Remove All"
		dk_call dk_echo " 8) Clear Screen"
		dk_call dk_echo " 9) Clear cmake cache and .tmp files"
		dk_call dk_echo "10) Reload"
		dk_call dk_echo "11) Exit"
		dk_call dk_echo
		dk_call dk_echo "Press Enter To Skip"
		dk_call dk_echo "${clr}"
	fi
	
	read input
	if [ "${input}" = "0" ]; then
		dk_call dk_echo "repeating last selection"
		APP=${_APP_}
		TARGET_OS=${_TARGET_OS_}
		TYPE=${_TYPE_}
		UPDATE=1
	elif [ "${input}" = "1" ]; then
		dk_call dk_gitUpdate
	elif [ "${input}" = "2" ]; then
		dk_call dk_gitCommit
	elif [ "${input}" = "3" ]; then
		dk_call dk_downloadDK
	elif [ "${input}" = "4" ]; then
		dk_call dk_pushAssets
	elif [ "${input}" = "5" ]; then
		dk_call dk_pullAssets
	elif [ "${input}" = "6" ]; then
		dk_call dk_resetAll
	elif [ "${input}" = "7" ]; then
		dk_call dk_removeAll
	elif [ "${input}" = "8" ]; then
		dk_call dk_clearScreen
	elif [ "${input}" = "9" ]; then
		dk_call dk_clearCmakeCache
		dk_call dk_deleteTempFiles
	elif [ "${input}" = "10" ]; then
		dk_call dk_reload
	elif [ "${input}" = "11" ]; then
		dk_call dk_exit 0	
	elif [ "${input}" = "" ]; then
		UPDATE=1
	else
		dk_call dk_warning "invalid selection"
	fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickUpdate
}
