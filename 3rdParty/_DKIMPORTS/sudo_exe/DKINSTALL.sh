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
# DKINSTALL
#
DKINSTALL() {
	dk_debugFunc 0

	(command -v "${sudo_exe-}" 1>/dev/null) && return $?;
	
	[ ! -e "${sudo_exe-}" ] && sudo_exe="/usr/bin/sudo"
	[ ! -e "${sudo_exe-}" ] && sudo_exe="C:/Windows/System32/sudo.exe"
	[ ! -e "${sudo_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && sudo_exe=$(cygpath -u "${sudo_exe}")
	[ ! -e "${sudo_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && sudo_exe=$(wslpath -u "${sudo_exe}")
	[ ! -e "${sudo_exe-}" ] && dk_call dk_installPackage sudo
	[ ! -e "${sudo_exe-}" ] && sudo_exe=$(command -v sudo)
	
	### Test exists
	[ -e "${sudo_exe-}" ] || { dk_call dk_error "sudo_exe:${sudo_exe} not found"; return $?; }
	
	### Test command
	(command -v "${sudo_exe-}" 1>/dev/null) || { dk_call dk_error "sudo_exe:${sudo_exe-} failed to run"; return $?; }
	
	###### output ######
	export sudo_exe=${sudo_exe};
#	if [ -n "${1-}" ]; then
#		eval ${1}=${sudo_exe};
#	else
		builtin echo "${sudo_exe}";
#	fi
	return $?;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_validate sudo_exe "dk_call dk_depend sudo_exe"
	dk_call dk_echo "sudo_exe = ${sudo_exe-}"
	
	dk_call dk_validate sudo_exe "dk_call dk_depend sudo_exe"
	dk_call dk_echo "sudo_exe = ${sudo_exe-}"
}