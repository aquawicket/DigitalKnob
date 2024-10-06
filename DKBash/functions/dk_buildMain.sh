#!/bin/sh
echo "dk_buildMain.sh()"
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
	
	#if dk_call dk_defined WSLENV; then
	if dk_call dk_defined WSLPATH_EXE; then
		dk_call dk_info "WSL is on"
		#dk_call dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
		#${SUDO_EXE} chown -R "${LOGNAME}" "${HOME}"
	fi

	dk_call dk_printVar SHLVL		# https://stackoverflow.com/a/4511483/688352
	dk_call dk_printVar MSYSTEM
	#dk_call dk_printVar DKSCRIPT_PATH
	#dk_call dk_printVar DKSCRIPT_DIR
	#dk_call dk_printVar DKSCRIPT_NAME
	
	### Get the host_triple and other HOST variables
	dk_call dk_host_triple
	dk_call dk_DKHOME_DIR
	dk_call dk_DIGITALKNOB_DIR
	dk_call dk_installGit
	dk_call dk_DKBRANCH_DIR

#	if [ "${DKSCRIPT_DIR}" != "${DKBRANCH_DIR}" ]; then
#		dk_call dk_warning "${DKSCRIPT_NAME} is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
#		dk_call dk_warning "${DKSCRIPT_NAME} path = ${DKSCRIPT_DIR}"
#		dk_call dk_warning "DKBRANCH_DIR path = ${DKBRANCH_DIR}"
#	fi
	
	while :
	do
		if [ -z "${UPDATE-}" ];     then dk_call dk_pickUpdate;  continue; fi
		if [ -z "${APP-}" ];        then dk_call dk_pickApp;     continue; fi
		if [ -z "${triple-}" ]; 	then dk_call dk_pickOs;      continue; fi
		if [ -z "${TYPE-}" ];       then dk_call dk_pickType;    continue; fi
		
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
