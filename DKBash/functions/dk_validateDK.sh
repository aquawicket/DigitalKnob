#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

#####################################################################
# dk_validateDK()
#
#
dk_validateDK(){
    dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	[ -n "${DKBRANCH}" ]		|| export DKBRANCH="Development"
	[ -n "${DKBRANCH_DIR}" ]	|| export DKBRANCH_DIR="${DIGITALKNOB_DIR}\${DKBRANCH}"
	
	[ -e "${DKBRANCH_DIR}\.git" ] && [ "${DKSCRIPT_NAME}" -ne "DKBuilder" ] && return
	[ -e "${DKBRANCH_DIR}\.git" ] && [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ] && return

    [ -e "${DKBRANCH_DIR}\.git" ] && dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git ${DKBRANCH}
	
	[ "${DKSCRIPT_NAME}" = "DKBuilder" ] && export DKSCRIPT_PATH="${DKBRANCH_DIR}\${DKSCRIPT_NAME}${DKSCRIPT_EXT}"
	[ ! -e "${DKSCRIPT_PATH}" ] && dk_call dk_fatal "DKSCRIPT_PATH:${DKSCRIPT_PATH} does not exist" && return
	
	[ "${DKSCRIPT_NAME}" = "DKBuilder" ] && export DKSCRIPT_ARGS="${DKSCRIPT_PATH}"
	DKSCRIPT_DIR=$(dirname "${DKSCRIPT_PATH}")
	#if [${DKSCRIPT_DIR:~-1}] == [\] set "DKSCRIPT_DIR=${DKSCRIPT_DIR:~0,-1}"
	#if [${DKSCRIPT_DIR:~-1}] == [/] set "DKSCRIPT_DIR=${DKSCRIPT_DIR:~0,-1}"
	unset RELOADED
	
	#set "DKSCRIPT_DIR=${DKBRANCH_DIR}"
	#set "DKSCRIPT_NAME="
	#set "DKSCRIPT_EXT="
	#set "DKBATCH_DIR="
	#set "DKBATCH_FUNCTIONS_DIR=${DKBRANCH_DIR}\DKBatch\functions"
	#set "DKBATCH_FUNCTIONS_DIR_="
	#set "DKASSETS_DIR="
}





####### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
    dk_debugFunc 0
    
    dk_call dk_validateDK
}
