#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_pickUpdate()
#
#
dk_pickUpdate() {
	dk_debugFunc 0

	#dk_call dk_readCache Target_App_Cache Target_Tuple_Cache Target_Type_Cache
	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
	dk_call dk_pathExists "${DKCACHE_DIR-}/DKBuilder.cache" && dk_call dk_fileVariables "${DKCACHE_DIR-}/DKBuilder.cache"
	
	dk_call dk_echo
	#dk_call dk_gitCheckRemote
	dk_call dk_echo

	if [ -n "${behind-}" ] && [ ${behind-} -gt 0 ]; then
		dk_call dk_warning "Your local repository is behind, please git update"
		dk_call dk_echo
		dk_echo "${red}" 
		if [ -n "${Target_App_Cache-}" ] && [ -n "${Target_Os_Cache-}" ] && [ -n "${Target_Arch_Cache-}" ] && [ -n "${Target_Env_Cache-}" ] && [ -n "${Target_Type_Cache-}" ]; then
			dk_call dk_echo " 0) Repeat Cache '${Target_App_Cache}_${Target_Os_Cache}_${Target_Arch_Cache}_${Target_Env_Cache}_${Target_Type_Cache}'"
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
	else
		if [ -n "${Target_App_Cache-}" ] && [ -n "${Target_Os_Cache-}" ] && [ -n "${Target_Arch_Cache-}" ] && [ -n "${Target_Env_Cache-}" ] && [ -n "${Target_Type_Cache-}" ]; then
			dk_call dk_echo " 0) Repeat Cache '${Target_App_Cache}_${Target_Os_Cache}_${Target_Arch_Cache}_${Target_Env_Cache}_${Target_Type_Cache}'"
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
	fi
	
	dk_call dk_keyboardInput choice
	#dk_call dk_keyboardInputTimeout choice 13 60
	
	if [ "${choice}" = "FIXME" ]; then
		dk_call dk_echo "repeating last selection"
		Target_App=${Target_App_Cache-}
		Target_Os=${Target_Os_Cache-}
		Target_Arch=${Target_Arch_Cache-}
		Target_Env=${Target_Env_Cache-}
		Target_Type=${Target_Type_Cache-}
		#Target_Tuple=${Target_Tuple_Cache-}
		pickUpdate=1
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
		pickUpdate=1
		return 1
	elif [ "${choice}" = "" ]; then
		pickUpdate=1
	else
		dk_call dk_warning "invalid selection"
	fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickUpdate
}
