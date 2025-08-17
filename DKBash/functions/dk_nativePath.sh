#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_nativePath(path ret_val)
#
#
dk_nativePath() {
	dk_debugFunc 1 2
	
	dk_call dk_validate Host_Os "dk_call dk_Host_Os"
	if [ "${Host_Os}" = "Windows" ]; then
		dk_call dk_getWindowsPath ${1} _winpath_
		#dk_return "${_winpath_//\\/\\\\}"; return
		local ret_val="${2-}"
		dk_call dk_printVar ret_val
		dk_return "${_winpath_}"; return
	else
		local ret_val="${2-}"
		dk_call dk_printVar ret_val
		dk_return "$(dk_readlink -f "${1}")"; return
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_nativePath "/c/Windows/System32" nativePath
	dk_call dk_echo "nativePath = ${nativePath}"
	
	#nativePathB=$(dk_call dk_nativePath "/c/Windows/System32")
	#dk_call dk_echo "nativePathB = ${nativePathB}"
}
