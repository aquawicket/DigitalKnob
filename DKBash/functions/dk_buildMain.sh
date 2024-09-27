#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

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
		#${dksudo} chown -R "${LOGNAME}" "${HOME}"
	fi

	dk_call dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
	dk_call dk_printVar MSYSTEM
	#dk_call dk_printVar DKSCRIPT_PATH
	#dk_call dk_printVar DKSCRIPT_DIR
	#dk_call dk_printVar DKSCRIPT_NAME
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_call dk_getHostTriple
	dk_call dk_getDKPaths
	dk_call dk_installGit
	dk_call dk_DKBRANCH_DIR

	#dk_call dk_printVar DKBRANCH_DIR
	#dk_call dk_printVar DKAPPS_DIR
	#dk_call dk_printVar DKCMAKE_DIR
	#dk_call dk_printVar DK3RDPARTY_DIR
	#dk_call dk_printVar DKIMPORTS_DIR
	#dk_call dk_printVar DKPLUGINS_DIR

	if [ "${DKSCRIPT_DIR}" != "${DKBRANCH_DIR}" ]; then
		dk_call dk_warning "${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_call dk_warning "${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}"
		dk_call dk_warning "DKBRANCH_DIR path = ${DKBRANCH_DIR}"
	fi
	
	while :
	do
		if [ -z "${UPDATE-}" ];     then dk_call dk_pickUpdate;  continue; fi
		if [ -z "${APP-}" ];        then dk_call dk_pickApp;     continue; fi
		if [ -z "${TARGET_OS-}" ];  then dk_call dk_pickOs;      continue; fi
		if [ -z "${TYPE-}" ];       then dk_call dk_pickType;    continue; fi
		
		dk_call dk_createCache
		dk_call dk_generate	
		dk_call dk_buildApp
		
		dk_call dk_unset UPDATE
		dk_call dk_unset APP
		dk_call dk_unset TARGET_OS
		dk_call dk_unset TYPE
	done
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildMain
}
