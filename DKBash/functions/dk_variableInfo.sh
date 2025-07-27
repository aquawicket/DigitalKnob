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
# dk_variable_info(name output)
#
#
dk_variable_info() {
	dk_debugFunc 2
	
	[ ${#} -ne 2 ] && return $(false)										# if not exactly 2 parameters
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# ^ as first character is not portable
	#$(expr "${2}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# ^ as first character is not portable
	$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	$(expr "${2}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	
	#FIXME: this only gets the first element of an array variable
	if dk_call dk_defined ${1}; then
		eval value='$'{$1}
		eval "${2}=\"${1} = '${value}'\""
	else
		eval "${2}=\"${1} = ${red}NOT DEFINED${clr}\""
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_variable_info
}
