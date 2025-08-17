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


####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
dk_DKDOWNLOAD_DIR() {
    dk_debugFunc 0 1
            
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKDOWNLOAD_DIR="${1}" 

	############ GET ############
	elif [ ! -e "${DKDOWNLOAD_DIR-}" ]; then
		dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR" 
		export DKDOWNLOAD_DIR="${DIGITALKNOB_DIR}/download"   
	fi 

	if [ ! -e "${DKDOWNLOAD_DIR}" ]; then
		dk_call dk_mkdir "${DKDOWNLOAD_DIR}" 
	fi 
	
	builtin echo "${DKDOWNLOAD_DIR-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKDOWNLOAD_DIR . . ."
	dk_call dk_DKDOWNLOAD_DIR
	dk_call dk_printVar DKDOWNLOAD_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKDOWNLOAD_DIR . . ."
	dk_call dk_DKDOWNLOAD_DIR "/C/DK/download"
	dk_call dk_printVar DKDOWNLOAD_DIR 
}
