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
