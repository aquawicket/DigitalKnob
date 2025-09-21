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
	
	(command -v "${reg_exe-}" 1>/dev/null) && return $?;
	
	[ ! -e "${reg_exe-}" ] && reg_exe=$(command -v reg)
	[ ! -e "${reg_exe-}" ] && reg_exe="C:/Windows/System32/reg.exe"
	[ ! -e "${reg_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && reg_exe=$(cygpath -u "${reg_exe}")
	[ ! -e "${reg_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && reg_exe=$(wslpath -u "${reg_exe}")
	[ ! -e "${reg_exe-}" ] && dk_call dk_installPackage reg
	(command -v ${reg_exe} 1>/dev/null) || { dk_call dk_error "reg_exe:${reg_exe} failed to run"; return $?; }
	
	###### output ######
	export reg_exe=${reg_exe};
	if [ -n "${1-}" ]; then
		eval ${1}=${reg_exe};
	else
		builtin echo "${reg_exe}";
	fi
	return $?;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_validate reg_exe "dk_call dk_depend reg_exe"
	dk_call dk_echo "reg_exe = ${reg_exe-}"
	
	dk_call dk_validate reg_exe "dk_call dk_depend reg_exe"
	dk_call dk_echo "reg_exe = ${reg_exe-}"
}