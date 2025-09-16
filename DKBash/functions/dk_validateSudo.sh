#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)								&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')								&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)									&& echo "bash_exe = ${bash_exe}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(dirname $0)											&& echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_validateSudo()
#
#
dk_validateSudo() {
	dk_debugFunc 0

	(command -v "sudo" >/dev/null 2>&1) 	&& export SUDO_EXE=$(command -v "sudo") || return
	(command -v "builtin" >/dev/null 2>&1) 	&& BUILTIN_EXE=$(command -v "builtin")
	(command -v 'cmd.exe' 1>/dev/null) 		&& export cmd_exe=$(command -v 'cmd.exe')
	[ -n "${cmd_exe-}" ] && DKSUDOPW=$(${cmd_exe} /c echo %DKSUDOPW% | tr -d '\r');
	
	if [ -n "${DKSUDOPW-}" ]; then
		${BUILTIN_EXE} echo ${DKSUDOPW} | ${SUDO_EXE} -S echo >/dev/null 2>&1 && (
			SUDO_EXE="builtin echo ${DKSUDOPW} | ${SUDO_EXE} -S";
		) || (
			echo "Password stored in DKSUDOPW failed"
		)		
	fi
	
	${SUDO_EXE} echo >/dev/null 2>&1 || echo "sudo password failed";
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validateSudo
}
