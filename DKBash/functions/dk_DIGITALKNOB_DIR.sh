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
		[ -n "${DIGITALKNOB-}" ] || export DIGITALKNOB="DigitalKnob"
		[ -n "${DIGITALKNOB_DIR-}" ] || export DIGITALKNOB_DIR="$(dk_call dk_DKHOME_DIR)/${DIGITALKNOB}"  
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
