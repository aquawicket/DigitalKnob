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


##############################################################################
# dk_isString(arg) -> rtn_var
# 
#	Test if arg1 is a string or a string variable
#
#	${1}			- The variable to test
#	${rtn_var}: 	- True if the argument is string or a string variable
#
dk_isString() {
	dk_debugFunc 1
	
	re='^[0-9]+$'
	dk_isVariable ${1} && local var=${!1} || local var=${1}

	[[ ${var} =~ ${re} ]] && return $(true) || return $(false)
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myString1="test string"
	dk_isString myString1        && dk_echo "myString1 is a string"       || dk_echo "myString1 is NOT a string"
	dk_isString "as string"      && dk_echo "'as string' is a string"     || dk_echo "'as string' is NOT a string"
	dk_isString no_quotes        && dk_echo "no_quotes is a string"       || dk_echo "no_quotes is NOT a string"
	dk_isString 'single quotes'  && dk_echo "'single quotes' is a string" || dk_echo "'single quotes' is NOT a string"
	dk_isString ""               && dk_echo "1 is a string"               || dk_echo "1 is NOT a string"
	
	#dk_echo "dk_isString myString1 = $(dk_isString myString1)"
	
	#if dk_isString myString1; then
	#	dk_echo "myString1 is a string"
	#else
	#	dk_echo "myString1 is NOT a string"
	#fi
}
