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


#################################################################################
# dk_keyboardInputTimeout(result, default, timeout)
#
#
dk_keyboardInputTimeout() {
	dk_debugFunc 3
	
	default=$2
	timeout=$3
	
	read -t ${timeout} -e input || $(true)
	input="${input:-${2}}"
	dk_echo "input = ${input}"
	eval $1='"${input}"'
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo "Type some input and press enter when done"
	dk_call dk_keyboardInputTimeout input "default text" 10
	dk_call dk_echo "you typed '${input}'"
}
