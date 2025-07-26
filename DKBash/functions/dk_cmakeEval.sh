#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
#
#			
dk_cmakeEval() {
	dk_debugFunc 1 3
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	#dk_call dk_validate CMAKE_EXE     "dk_call ${DKIMPORTS_DIR}/cmake/DKINSTALL.cmake.sh"
	dk_call dk_validate CMAKE_EXE     "dk_call dk_depend cmake"
	dk_call dk_validate DKCMAKE_DIR   "dk_call dk_DKBRANCH_DIR"
	
	DKCOMMAND="${1}"
	DKRETURN="${2-}"
	DKVARS="${3-}"
	#set DKCOMMAND=$DKCOMMAND:"=%"  #TODO: remove double quotes
	
	### build cmake command ###
	set -- #clear the positional parameters
	[ -n "${DKCOMMAND}" ] && set -- "${@}" "-DDKCOMMAND=${DKCOMMAND}" || dk_call dk_error "DKCOMMAND is invalid"
	[ -n "${DKRETURN}" ]  && set -- "${@}" "-DDKRETURN=${DKRETURN}"
	[ -n "${DKVARS}" ]    && set -- "${@}" "${DKVARS}"
	set -- "${@}" "-P"
	set -- "${@}" "${DKCMAKE_DIR}/DKEval.cmake"
	
	### call the cmake command 
	dk_call "${CMAKE_EXE}" "${@}"
	
	### get the return variables
	if [ -n "${DKRETURN}" ]; then 
		if dk_call dk_pathExists "${DKCMAKE_DIR}"/cmake_vars; then
			. "${DKCMAKE_DIR}"/cmake_vars
			rm ${DKCMAKE_DIR}/cmake_vars
		fi
	fi

	#dk_call dk_debug return code: ${?}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_cmakeEval "dk_debug('sent with dk_cmakeEval')" "CMAKE_CURRENT_LIST_DIR"
	dk_call dk_printVar CMAKE_CURRENT_LIST_DIR
}
