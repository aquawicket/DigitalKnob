#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


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
	
	if [ ! -e "${DKDESKTOP_DIR}/DigitalKnob" ]; then
		if [ -e "${DKDESKTOP_DIR}" ]; then
			echo 'dk_call dk_createSymlink "${DIGITALKNOB_DIR}" "${DKDESKTOP_DIR}/DigitalKnob"';
		fi
	fi
	
#	if [ ! -e "${DKDESKTOP_DIR}/DKBuilder.sh" ]; then
#		if [ -e "${DKBRANCH_DIR}/DKBash/apps/DKBuilder/DKBuilder.sh" ]; then
#			dk_call dk_createSymlink "${DKBRANCH_DIR}/DKBash/apps/DKBuilder/DKBuilder.sh" "${DKDESKTOP_DIR}/DKBuilder.sh"
#		fi
#	fi
	
	#dk_call dk_quickAccessPin "${DIGITALKNOB_DIR}"
	
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
			dk_call dk_fileToMatrix "${BUILD_LIST_FILE}" BUILD_LIST
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
					Target_App="${BUILD_LIST[${_line},0]}"
					Target_Tuple="${BUILD_LIST[${_line},1]}"
					Target_Type="${BUILD_LIST[${_line},2]}"
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
		echo "UPDATE 		= ${UPDATE-}"
		echo "Target_App 	= ${Target_App-}"
		echo "Target_Os 	= ${Target_Os-}"
		echo "Target_Arch 	= ${Target_Arch-}"
		echo "Target_Env 	= ${Target_Env-}"
		echo "Target_Type 	= ${Target_Type-}"
		echo "Target_Tuple 	= ${Target_Tuple-}"
		
		[ -z "${Target_App-}" ]		&& dk_call dk_Target_App
		[ -z "${Target_Os-}" ]		&& dk_call dk_Target_Os
		[ -z "${Target_Arch-}" ]	&& dk_call dk_Target_Arch
		[ -z "${Target_Env-}" ]		&& dk_call dk_Target_Env
		[ -z "${Target_Type-}" ] 	&& dk_call dk_Target_Type
		[ -z "${Target_Tuple-}" ] 	&& dk_call dk_Target_Tuple
		
		# save selections to DKBuilder.cache file
		dk_call dk_validate DKCACHE_DIR "dk_DKCACHE_DIR"
		dk_call dk_fileWrite "${DKCACHE_DIR}/DKBuilder.cache" "Target_App_Cache=${Target_App-}"
		dk_call dk_fileAppend "${DKCACHE_DIR}/DKBuilder.cache" "Target_Os_Cache=${Target_Os-}"
		dk_call dk_fileAppend "${DKCACHE_DIR}/DKBuilder.cache" "Target_Arch_Cache=${Target_Arch-}"
		dk_call dk_fileAppend "${DKCACHE_DIR}/DKBuilder.cache" "Target_Env_Cache=${Target_Env-}"
		dk_call dk_fileAppend "${DKCACHE_DIR}/DKBuilder.cache" "Target_Type_Cache=${Target_Type-}"
	
		
		############ CMAKE Command ###################
		dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
		dk_call dk_chdir ${DKCPP_APPS_DIR}/${Target_App}
		export DKSCRIPT_PATH
		dk_call dk_validate CMAKE_EXE "dk_call dk_depend cmake"
		echo "${CMAKE_EXE-} -P ${DKCPP_APPS_DIR}/${Target_App}/DKINSTALL.cmake"
		${CMAKE_EXE} -P "${DKCPP_APPS_DIR}/${Target_App}/DKINSTALL.cmake"
		
		#dk_call dk_generate	
		#dk_call dk_buildApp
		
		if [ ! -e "${BUILD_LIST_FILE-}" ]; then
			dk_call dk_unset UPDATE
		fi
		dk_call dk_unset Target_App
		dk_call dk_unset Target_Os
		dk_call dk_unset Target_Arch
		dk_call dk_unset Target_Env
		dk_call dk_unset Target_Type
		dk_call dk_unset Target_Tuple
	done
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_buildMain
}
