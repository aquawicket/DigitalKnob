#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_pickUpdate()
#
#
dk_pickUpdate() {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	dk_readCache
	
	dk_echo
	dk_checkGitRemote
	dk_echo
	
	#dk_printVar _APP_
	#dk_printVar _TARGET_OS_ 
	#dk_printVar _TYPE_
	
	if [ $behind -lt 1 ]; then
		if [ -n "${_APP_-}" ] && [ -n "${_TARGET_OS_-}" ] && [ -n "${_TYPE_-}s" ]; then
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		fi
		dk_echo " 1) Git Update"   
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo " Press Enter To Skip"
	else
		dk_warning "Your local repository is behind, please git update"
		dk_echo
		dk_echo "${red}" 
		if [ -n "${_APP_}" ] && [ -n "${_TARGET_OS_}" ] && [ -n "${_TYPE_}" ]; then
			dk_echo " 0) Repeat cache [${_APP_} - ${_TARGET_OS_} - ${_TYPE_}]"
		fi
		dk_echo "${green}"
		dk_echo " 1) Git Update"
		dk_echo "${red}"  
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo "Press Enter To Skip"
		dk_echo "${clr}"
	fi
	
	read input
	if [ "${input}" = "0" ]; then
		dk_echo "repeating last selection"
		APP=${_APP_}
		TARGET_OS=${_TARGET_OS_}
		TYPE=${_TYPE_}
		UPDATE=1
	elif [ "${input}" = "1" ]; then
		dk_gitUpdate
	elif [ "${input}" = "2" ]; then
		dk_gitCommit
	elif [ "${input}" = "3" ]; then
		dk_pushAssets
	elif [ "${input}" = "4" ]; then
		dk_pullAssets
	elif [ "${input}" = "5" ]; then
		dk_resetAll
	elif [ "${input}" = "6" ]; then
		dk_removeAll
	elif [ "${input}" = "7" ]; then
		dk_clearScreen
	elif [ "${input}" = "8" ]; then
		dk_clearCmakeCache
		dk_deleteTempFiles
	elif [ "${input}" = "9" ]; then
		dk_reload
	elif [ "${input}" = "10" ]; then
		dk_exit 0	
	elif [ "${input}" = "" ]; then
		UPDATE=1
	else
		dk_warning "invalid selection"
	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_pickUpdate
}