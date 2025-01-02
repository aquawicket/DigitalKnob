#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

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
		if [ -e "${BUILD_LIST_FILE}" ]; then
			declare -A BUILD_LIST
			dk_call dk_fileToGrid "${BUILD_LIST_FILE}" BUILD_LIST
			[ -n ${line-} ] || line=0
			comment_check="${BUILD_LIST[${line-},0]}"			
			if [ "${comment_check:0:1}" = "#" ]; then
				(($line+=1))
				echo "skipping line . . ."
			else
				if [ -n "${BUILD_LIST[${line},2]}" ]; then
					UPDATE=1
					target_app="${BUILD_LIST[${line},0]}"
					target_triple="${BUILD_LIST[${line},1]}"
					target_type="${BUILD_LIST[${line},2]}"
					(($line+=1))
				else
					BUILD_LIST_FILE=""
				fi
			fi
		fi
		
		[ -z "${UPDATE-}" ] 		&& dk_call dk_pickUpdate
		[ -z "${target_app-}" ]    	&& dk_call dk_target_app
		[ -z "${target_triple-}" ] 	&& dk_call dk_target_triple_SET
		[ -z "${target_type-}" ]    && dk_call dk_target_type
		
		# save selections to cache file
		dk_call dk_echo "creating cache..."
		dk_call dk_validate DKCACHE_DIR "dk_DKCACHE_DIR"
		dk_call dk_fileWrite "${DKCACHE_DIR}/cache" "${target_app-} ${target_triple-} ${target_type-}"
	
		dk_call dk_generate	
		dk_call dk_buildApp
		
		dk_call dk_unset UPDATE
		dk_call dk_unset target_app
		dk_call dk_unset target_triple
		dk_call dk_unset target_type
	done
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildMain
}
