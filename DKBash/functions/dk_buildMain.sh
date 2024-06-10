#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_buildMain()
#
#
dk_buildMain () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
	dk_validateSudo
	
	if dk_defined WSLENV; then 
		dk_info "WSLENV is on"
		dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
		sudo chown -R "${LOGNAME}" "${HOME}"
	fi

	dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
	dk_printVar MSYSTEM
	#dk_printVar DKSCRIPT_PATH
	#dk_printVar DKSCRIPT_DIR
	#dk_printVar DKSCRIPT_NAME
	
	### Get the HOST_TRIPLE and other HOST variables
	dk_getHostTriple
	
	dk_getDKPaths

	dk_validateGit
	dk_validateBranch

	#dk_printVar DKBRANCH_DIR
	#dk_printVar DKAPPS_DIR
	#dk_printVar DKCMAKE_DIR
	#dk_printVar DK3RDPARTY_DIR
	#dk_printVar DKIMPORTS_DIR
	#dk_printVar DKPLUGINS_DIR

	if [ "${DKSCRIPT_DIR}" != "${DKBRANCH_DIR}" ]; then
		dk_warning "${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}"
		dk_warning "DKBRANCH_DIR path = ${DKBRANCH_DIR}"
	fi
	
	while :
	do
		if [ -z "${UPDATE-}" ];     then dk_pickUpdate;  continue; fi
		if [ -z "${APP-}" ];        then dk_pickApp;     continue; fi
		if [ -z "${TARGET_OS-}" ];  then dk_pickOs;      continue; fi
		if [ -z "${TYPE-}" ];       then dk_pickType;    continue; fi
		
		dk_createCache
		dk_generate	
		dk_build
		
		dk_unset UPDATE
		dk_unset APP
		dk_unset TARGET_OS
		dk_unset TYPE
	done
}






DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_buildMain
}