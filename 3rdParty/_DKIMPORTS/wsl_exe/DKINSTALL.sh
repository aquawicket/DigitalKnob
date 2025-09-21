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

	(command -v "${wsl_exe-}" 1>/dev/null) && return $?;
	
	[ ! -e "${wsl_exe-}" ] && wsl_exe="/usr/bin/wsl"
	[ ! -e "${wsl_exe-}" ] && wsl_exe="C:/Windows/System32/wsl.exe"
	[ ! -e "${wsl_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && wsl_exe=$(cygpath -u "${wsl_exe}")
	[ ! -e "${wsl_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && wsl_exe=$(wslpath -u "${wsl_exe}")
	[ ! -e "${wsl_exe-}" ] && dk_call dk_installPackage wsl
	[ ! -e "${wsl_exe-}" ] && wsl_exe=$(command -v wsl)
	
	### Test exists
	[ -e "${wsl_exe-}" ] || { dk_call dk_error "wsl_exe:${wsl_exe} not found"; return $?; }
	
	### Test command
	(command -v "${wsl_exe-}" 1>/dev/null) || { dk_call dk_error "wsl_exe:${wsl_exe-} failed to run"; return $?; }
	
	###### output ######
	export wsl_exe=${wsl_exe};
#	if [ -n "${1-}" ]; then
#		eval ${1}=${wsl_exe};
#	else
		builtin echo "${wsl_exe}";
#	fi
	return $?;
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_validate wsl_exe "dk_call dk_depend wsl_exe"
	dk_call dk_echo "wsl_exe = ${wsl_exe-}"
	
	dk_call dk_validate wsl_exe "dk_call dk_depend wsl_exe"
	dk_call dk_echo "wsl_exe = ${wsl_exe-}"
}