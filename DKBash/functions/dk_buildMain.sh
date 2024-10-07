#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_buildMain()
#
#
dk_buildMain() {
	dk_debugFunc 0

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
	dk_call dk_validateSudo
	
	if dk_call dk_defined WSLENV; then 
		dk_call dk_info "WSLENV is on"
		#dk_call dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
		#${SUDO_EXE} chown -R "${LOGNAME}" "${HOME}"
	fi
	
	while :
	do
		[ -z "${UPDATE-}" ] && dk_call dk_pickUpdate
		[ -z "${APP-}" ]    && dk_call dk_pickApp
		[ -z "${triple-}" ] && dk_call dk_pickOs
		[ -z "${TYPE-}" ]   && dk_call dk_pickType
		
		dk_call dk_createCache
		dk_call dk_generate	
		dk_call dk_buildApp
		
		dk_call dk_unset UPDATE
		dk_call dk_unset APP
		dk_call dk_unset triple
		dk_call dk_unset TYPE
	done
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildMain
}
