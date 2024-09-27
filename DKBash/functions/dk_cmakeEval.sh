#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_cmakeEval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
#
#			
dk_cmakeEval() {
	dk_debugFunc 1 3
	
	dk_call dk_validate CMAKE_EXE "dk_call dk_installCmake"
	dk_call dk_validate DKCMAKE_DIR "dk_call dk_DKBRANCH_DIR"
	
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
	dk_call dk_call "${CMAKE_EXE}" "${@}"
	
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
