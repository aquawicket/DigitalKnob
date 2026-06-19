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


##################################################################################
# dk_onExit()
#
#
dk_onExit() {
	### dk_onExit options# #######################################################
	[ -z "${KEY_WAIT_ON_EXIT-}" ]	&& dk_call dk_export KEY_WAIT_ON_EXIT 0
	[ -z "${STAY_OPEN_ON_EXIT-}" ]	&& dk_call dk_export STAY_OPEN_ON_EXIT 0
	##############################################################################

	dk_debugFunc 0
	dk_call dk_debug "dk_onExit($*)";

#	[ ${KEY_WAIT_ON_EXIT} -eq 1 ]		&& [ $SHLVL -eq 1 ] && dk_pause
#	[ ${STAY_OPEN_ON_EXIT} -eq 1 ]		&& [ $SHLVL -eq 1 ] && exec ${SHELL}
	[ ${KEY_WAIT_ON_EXIT-1} -eq 1 ]		&& dk_call dk_pause
	[ ${STAY_OPEN_ON_EXIT-0} -eq 1 ]	&& exec ${SHELL}
}
trap 'dk_onExit' EXIT




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_call dk_echo "calling exit . . ."
	dk_call dk_exit $?

	# Only 'dk_exit 0' will turn the trap off
	# dk_exit 0
}