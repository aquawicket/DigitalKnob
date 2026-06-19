#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##############################################################################
# dk_isNumber(arg) -> rtn_var
# 
#	Test if arg1 is a number or a number variable
#
#	${1}			- The variable to test
#	${rtn_var}: 	- True if the argument is string or a string variable
#
dk_isNumber() {
	dk_debugFunc 1
	
	re='^[0-9]+$'
	#dk_call dk_isVariable ${1} && local var=${!1} || local var=${1}
	local var=${1}

	#[[ ${var} =~ ${re} ]] && return $(true) || return $(false)
	[[ ${var} =~ ${re} ]]
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myNumber1=69
	dk_isNumber myNumber1      && dk_echo "myNumber1 is a number"        || dk_echo "myNumber1 is NOT a number"
	dk_isNumber "myNumber1"    && dk_echo "\"myNumber1\" is a number"    || dk_echo "myNumber1 is NOT a number"
	dk_isNumber ${myNumber1}   && dk_echo "${myNumber1} is a number"     || dk_echo "${myNumber1} is NOT a number"
	dk_isNumber "${myNumber1}" && dk_echo "\"${myNumber1}\" is a number" || dk_echo "${myNumber1} is NOT a number"
	dk_isNumber 23             && dk_echo "23 is a number"               || dk_echo "23 is NOT a number"
	dk_isNumber 123.456        && dk_echo "123.456 is a number"          || dk_echo "123.456 is NOT a number"
	dk_isNumber 0              && dk_echo "0 is a number"                || dk_echo "0 is NOT a number"
	dk_isNumber 1              && dk_echo "1 is a number"                || dk_echo "1 is NOT a number"
	
	#dk_echo "dk_isNumber myNumber1 = $(dk_isNumber myNumber1)"
	
	#if dk_isNumber myNumber1; then
	#	dk_echo "myNumber1 is a number"
	#else
	#	dk_echo "myNumber1 is NOT a number"
	#fi
}
