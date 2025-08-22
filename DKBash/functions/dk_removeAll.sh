#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_removeAll()
#
#
dk_removeAll() {
	dk_debugFunc 0

	
	dk_call dk_clearScreen
	dk_call dk_echo
	dk_call dk_echo
	dk_call dk_info "Do you want to delete the entire local repository . . . ?"
	dk_call dk_info "This will delete the local DigitalKnob branch repository"
	dk_call dk_info "Save any un-commited changes first."
	dk_call dk_echo
		
	dk_call dk_confirm || return
		
	# make sure script is running from DKBRANCH_DIR
	#if ! [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ]; then
	#	dk_echo "${yellow}"
	#	dk_echo "WARNING: this file isn't running from the branch directory"
	#	dk_echo "Is must be in the branch directory to continue."
	#	dk_echo "${clr}"
    #    dk_printVar DKSCRIPT_DIR
	#	dk_printVar DKBRANCH_DIR
	#	return $(false);
	#fi
		
	# Backup main script file to DKCACHE_DIR/
	rm -r -f "${DKCACHE_DIR}/${DKSCRIPT_FILE}"
	cp "${DKSCRIPT_PATH}" "${DKCACHE_DIR}/${DKSCRIPT_FILE}"
	dk_call dk_freshRun "${DKCACHE_DIR}/${DKSCRIPT_FILE}" & dk_echo "DELETING ${DKBRANCH_DIR} . . . ." & rm -r -f "${DKBRANCH_DIR}" 2>/dev/null
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_removeAll
}