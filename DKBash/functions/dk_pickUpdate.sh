#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_pickUpdate()
#
#
dk_pickUpdate() {
	dk_debugFunc 0

	dk_call dk_readCache _APP_ _triple_ _TYPE_
	
	dk_call dk_echo
	dk_call dk_gitCheckRemote
	dk_call dk_echo

	if [ $behind -lt 1 ]; then
		if [ -n "${_APP_-}" ] && [ -n "${_triple_-}" ] && [ -n "${_TYPE_-}" ]; then
			dk_call dk_echo " 0) Repeat DKBuilder.cache [$_APP_ - $_triple_ - $_TYPE_]"
		fi
		dk_call dk_echo " 1) Git Update"   
				dk_echo " 2) Git Commit"
				dk_echo " 3) Download DigitalKnob"
				dk_echo " 4) Push assets"
				dk_echo " 5) Pull assets"
				dk_echo " 6) Reset All"
				dk_echo " 7) Remove All"
				dk_echo " 8) Clear Screen"
				dk_echo " 9) Reload"
				dk_echo "10) Exit"
				dk_call dk_validate DKBRANCH_DIR "dk_DKBRANCH_DIR"
				[ -e "${DKBRANCH_DIR}/build_list.txt" ] && dk_echo "11) Run 'build_list.txt'"
	
				dk_echo
				dk_echo " Press Enter To Skip"
	else
		dk_call dk_warning "Your local repository is behind, please git update"
		dk_call dk_echo
		dk_echo "${red}" 
		if [ -n "${_APP_-}" ] && [ -n "${_triple_-}" ] && [ -n "${_TYPE_-}" ]; then
			dk_echo " 0) Repeat DKBuilder.cache [${_APP_} - ${_triple_} - ${_TYPE_}]"
		fi
		dk_echo "${green}"
		dk_echo " 1) Git Update"
		dk_echo "${red}"  
		dk_echo " 2) Git Commit"
		dk_echo " 3) Download DigitalKnob"
		dk_echo " 4) Push assets"
		dk_echo " 5) Pull assets"
		dk_echo " 6) Reset All"
		dk_echo " 7) Remove All"
		dk_echo " 8) Clear Screen"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo "Press Enter To Skip"
		dk_echo "${clr}"
	fi
	
	dk_call dk_keyboardInput choice
	#dk_call dk_keyboardInputTimeout choice 13 60
	
	if [ "${choice}" = "0" ]; then
		dk_call dk_echo "repeating last selection"
		target_app=${_APP_}
		target_triple=${_triple_}
		target_type=${_TYPE_}
		UPDATE=1
	elif [ "${choice}" = "1" ]; then
		dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
	elif [ "${choice}" = "2" ]; then
		dk_call dk_gitCommit
	elif [ "${choice}" = "3" ]; then
		dk_call dk_downloadDK
	elif [ "${choice}" = "4" ]; then
		dk_call dk_pushAssets
	elif [ "${choice}" = "5" ]; then
		dk_call dk_pullAssets
	elif [ "${choice}" = "6" ]; then
		dk_call dk_resetAll
	elif [ "${choice}" = "7" ]; then
		dk_call dk_removeAll
	elif [ "${choice}" = "8" ]; then
		dk_call dk_clearScreen
	elif [ "${choice}" = "9" ]; then
		dk_call dk_reload
	elif [ "${choice}" = "10" ]; then
		dk_call dk_exit 0
	elif [ "${choice}" = "11" ]; then
		BUILD_LIST_FILE="${DKBRANCH_DIR}/build_list.txt"
		UPDATE=1
		return 1
	elif [ "${choice}" = "" ]; then
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
