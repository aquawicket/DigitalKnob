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


##################################################################################
# dk_isVariable(arg)
#
#
dk_isVariable() {
	dk_debugFunc 1
	
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)   	# ^ as first character is not portable
	$(expr "${1}" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	#dk_echo "${green}${name} is [:word:]${clr}"
	
	eval value='$'{${1}+x} 	# value will = 'x' if the variable is defined
	[ -n "${value}" ]
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	varA="A simple string variable"
	if dk_isVariable varA; then
		dk_echo "varA is a variable"
	else
		dk_echo "varA is NOT a variable"
	fi
	
	#varB="A non existent variable"
	if dk_isVariable varB; then
		dk_echo "varB is a variable"
	else
		dk_echo "varB is NOT a variable"
	fi
}
