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


##################################################################################
#[ -z "${KEY_WAIT_ON_EXIT-}" ] && dk_export KEY_WAIT_ON_EXIT 1
#[ -z "${STAY_OPEN_ON_EXIT-}" ] && dk_export STAY_OPEN_ON_EXIT 0
##################################################################################
# dk_onExit()
#
#
dk_onExit() {
	dk_debugFunc 0

#	[ ${KEY_WAIT_ON_EXIT} -eq 1 ] && [ $SHLVL -eq 1 ] && dk_pause
#	[ ${STAY_OPEN_ON_EXIT} -eq 1 ] && [ $SHLVL -eq 1 ] && exec ${SHELL}
	[ ${KEY_WAIT_ON_EXIT-1} -eq 1 ] && dk_call dk_pause
	[ ${STAY_OPEN_ON_EXIT-0} -eq 1 ] && exec ${SHELL}
}
trap 'dk_onExit' EXIT




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_echo "calling exit . . ."
	dk_exit $?

	# Only 'dk_exit 0' will turn the trap off
	# dk_exit 0
}