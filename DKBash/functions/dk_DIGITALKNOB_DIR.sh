#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


#####################################################################
# dk_DIGITALKNOB_DIR()
#
#
dk_DIGITALKNOB_DIR() {
	dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DIGITALKNOB_DIR="${1}" 

	############ GET ############
	else
		[ -n "${DIGITALKNOB-}" ]			|| export DIGITALKNOB="DigitalKnob"
		[ -n "${DIGITALKNOB_DIR-}" ]		|| export DIGITALKNOB_DIR="$(dk_call dk_DKHOME_DIR)/${DIGITALKNOB}"
		[ -n "${DKHTTP_DIGITALKNOB-}" ] 	|| export DKHTTP_DIGITALKNOB="DigitalKnob"
		export DKHTTP_DKHOME_DIR="http://aquawicket.com/DigitalKnob";
		[ -n "${DKHTTP_DIGITALKNOB_DIR-}" ]	|| export DKHTTP_DIGITALKNOB_DIR="${DKHTTP_DKHOME_DIR}/${DKHTTP_DIGITALKNOB}"
	fi 
	
	########## FINALIZE ############
	if [ ! -e "${DIGITALKNOB_DIR}" ]; then
		dk_call dk_mkdir "${DIGITALKNOB_DIR}" 
	fi
	
	builtin echo "${DIGITALKNOB_DIR}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DIGITALKNOB_DIR . . .";
    dk_call dk_echo "DIGITALKNOB_DIR = '$(dk_call dk_DIGITALKNOB_DIR)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DIGITALKNOB_DIR . . .";
	dk_call dk_echo "DIGITALKNOB_DIR = '$(dk_call dk_DIGITALKNOB_DIR '/c/Digital Knob')'";
}
