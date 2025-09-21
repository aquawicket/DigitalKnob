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

	(command -v "${curl_exe-}" 1>/dev/null) && return $?;
	
	[ ! -e "${curl_exe-}" ] && curl_exe=$(command -v curl)
	[ ! -e "${curl_exe-}" ] && curl_exe="C:/Windows/System32/curl.exe"
	[ ! -e "${curl_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && curl_exe=$(cygpath -u "${curl_exe}")
	[ ! -e "${curl_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && curl_exe=$(wslpath -u "${curl_exe}")
	[ ! -e "${curl_exe-}" ] && dk_call dk_installPackage curl
	(command -v "${curl_exe}" 1>/dev/null) || { dk_call dk_error "curl_exe:${curl_exe} failed to run"; return $?; }
	
	###### output ######
	export curl_exe=${curl_exe};
	if [ -n "${1-}" ]; then
		eval ${1}=${curl_exe};
	else
		builtin echo "${curl_exe}";
	fi
	return $?;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_validate curl_exe "dk_call dk_depend curl_exe"
	dk_call dk_echo "curl_exe = ${curl_exe-}"
	
	dk_call dk_validate curl_exe "dk_call dk_depend curl_exe"
	dk_call dk_echo "curl_exe = ${curl_exe-}"
}