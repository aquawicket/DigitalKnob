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


####################################################################
# dk_DKUSERNAME()
#
#
dk_DKUSERNAME() {
    dk_debugFunc 0 1;

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKUSERNAME="${1}" ;

	############ GET ############
	else
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USER-}";
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USERNAME-}";
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${LOGNAME-}";
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="UNDEFINED";
	fi
	
	builtin echo "${DKUSERNAME}";
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0;
 
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKUSERNAME . . .";
    dk_call dk_echo "DKUSERNAME = '$(dk_call dk_DKUSERNAME)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKUSERNAME . . .";
	dk_call dk_echo "DKUSERNAME = '$(dk_call dk_DKUSERNAME 'MyUsername')'";
}
