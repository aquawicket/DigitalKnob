#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_buildMain()
#
#
dk_buildMain() {
	dk_debugFunc 0

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
	dk_call dk_validateSudo
	dk_call dk_validate DKDESKTOP_DIR		"dk_call dk_DKDESKTOP_DIR"
	dk_call dk_validate DIGITALKNOB_DIR		"dk_call dk_DIGITALKNOB_DIR"
	dk_call dk_validate DKBRANCH_DIR		"dk_call dk_DKBRANCH_DIR"
	
	if [ ! -e "${DKDESKTOP_DIR}/digitalknob" ]; then
		if [ -e "${DKDESKTOP_DIR}" ]; then
			dk_call dk_createSymlink "${DIGITALKNOB_DIR}" "${DKDESKTOP_DIR}/digitalknob"
		fi
	fi
	
	if [ ! -e "${DKDESKTOP_DIR}/DKBuilder.sh" ]; then
		if [ -e "${DKBRANCH_DIR}/DKBash/apps/DKBuilder/DKBuilder.sh" ]; then
			dk_call dk_createSymlink "${DKBRANCH_DIR}/DKBash/apps/DKBuilder/DKBuilder.sh" "${DKDESKTOP_DIR}/DKBuilder.sh"
		fi
	fi
	
	#dk_call dk_pinToQuickAccess "${DIGITALKNOB_DIR}"
	
	if dk_call dk_defined WSLENV; then 
		dk_call dk_info "WSLENV is on"
		#dk_call dk_info "calling sudo chown -R ${LOGNAME} ${HOME} to allow windows write access to \\\wsl.localhost\DISTRO\home\\${LOGNAME}"
		#${SUDO_EXE} chown -R "${LOGNAME}" "${HOME}"
	fi
	
	while :
	do
		[ -z "${UPDATE-}" ] && dk_call dk_pickUpdate || true
		
		if [ -e "${BUILD_LIST_FILE-}" ]; then
			UPDATE=1
			declare -A BUILD_LIST
			dk_call dk_fileToGrid "${BUILD_LIST_FILE}" BUILD_LIST
			[ -n "${_line-}" ] || _line=0
			
			echo ""
			echo "_line = ${_line}"
			echo "0 = '${BUILD_LIST[${_line},0]-}'"
			echo "1 = '${BUILD_LIST[${_line},1]-}'"
			echo "2 = '${BUILD_LIST[${_line},2]-}'"
			echo ""			
			
			if [ "${BUILD_LIST[${_line},0]:0:1}" = "#" ]; then
				_line=$(( _line + 1 ))
				echo "skipping line . . ."
				continue
			else
				if [ -n "${BUILD_LIST[${_line},2]-}" ]; then
					target_app="${BUILD_LIST[${_line},0]}"
					target_triple="${BUILD_LIST[${_line},1]}"
					target_type="${BUILD_LIST[${_line},2]}"
#					echo ""
#					echo "UPDATE = ${UPDATE-}"
#					echo "_line = ${_line}"
#					echo "0 = ${BUILD_LIST[${_line},0]-}"
#					echo "1 = ${BUILD_LIST[${_line},1]-}"
#					echo "2 = ${BUILD_LIST[${_line},2]-}"
#					echo ""				
					_line=$(( _line + 1 ))
				else
					BUILD_LIST_FILE=""
				fi
			fi
		fi
		echo "UPDATE = ${UPDATE-}"
		echo "target_app = ${target_app-}"
		echo "target_triple = ${target_triple-}"
		echo "target_type = ${target_type-}"
		
		[ -z "${target_app-}" ] && dk_call dk_target_app
		[ -z "${target_triple-}" ] && dk_call dk_target_triple_SET
		[ -z "${target_type-}" ] && dk_call dk_target_type
		
		# save selections to DKBuilder.cache file
		dk_call dk_echo "creating DKBuilder.cache..."
		dk_call dk_validate DKCACHE_DIR "dk_DKCACHE_DIR"
		dk_call dk_fileWrite "${DKCACHE_DIR}/DKBuilder.cache" "${target_app-} ${target_triple-} ${target_type-}"
	
		dk_call dk_generate	
		dk_call dk_buildApp
		
		if [ ! -e "${BUILD_LIST_FILE-}" ]; then
			dk_call dk_unset UPDATE
		fi
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
