#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_includeGuard()
#
#
alias dk_includeGuard='{
	[ -z ${BASH_SOURCE[0]} ] && dk_call dk_echo "BASH_SOURCE[0] is empty"
	path=${BASH_SOURCE[0]}
	filename=${path##*/}
	filename=${filename##*\\}
	name="${filename%.*}"
	eval value=\${include_guard_$name}
	
	if [ -n "${value}" ]; then
		dk_call dk_warning "${path} already included"
		return 1 2>/dev/null
		dk_call dk_exit 1
	else	
		export readonly include_guard_${name}=1
	fi
}'





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	. ${DKBASH_FUNCTIONS_DIR}/dk_debug
	. ${DKBASH_FUNCTIONS_DIR}/dk_debug
	dk_call dk_debug "testing dk_includeGuard. loading of dk_debug should have been stopped twice."
}
