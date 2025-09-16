#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
[ -z ${PAUSE_ON_EXIT-} ] && PAUSE_ON_EXIT=1
##################################################################################
# dk_exit(exit_code)
#
#
dk_exit() {
	dk_debugFunc 0 1;
	
	trap '' EXIT;
	[ -n "${1-}" ] && export exit_code=${1};
	[ -z "${exit_code-}" ] && export exit_code=${?};
	[ -z "${exit_code-}" ] && export exit_code=0;
	
	[ ${PAUSE_ON_EXIT} = 1 ] && dk_call dk_echo "*** PAUSE_ON_EXIT: exit_code:${exit_code-} ***" && dk_call dk_pause || $(true)
	
	exit ${exit_code};
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	#Note: Only 'dk_exit 0' will turn the dk_onExit trap off
	
	#dk_call dk_exit
	#dk_call dk_exit 0
	#dk_call dk_exit 123
	dk_call dk_exit 13
}
