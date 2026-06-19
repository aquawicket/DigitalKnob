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
# dk_realpath(path, rtn_var)
#
#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
#    C: 	https://pubs.opengroup.org/onlinepubs/9699919799/functions/realpath.html
#
dk_realpath(){
	dk_debugFunc 1 2
	#[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${*}): not enough arguments"
	#[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${*}): too many arguments"
	
	local _realpath_=""
	if (command -v realpath &>/dev/null); then
		_realpath_=$(realpath "${1}")
	elif (command -v readlink &>/dev/null); then
		$(dk_readlink -f "${1}") && _realpath_=$(dk_readlink -f "${1}") || _realpath_=$(dk_readlink "${1}") #dk_fixme("MacOS readlink has no -f parameter")
	else	
		_realpath_=$(cd $(dirname ${1}); pwd -P)/$(basename ${1})
	fi
	
	###### return ######
	#dk_call dk_printVar _realpath_
	[ ${#} -gt 1 ] && eval "${2}=${_realpath_}" && return  # return value when using rtn_var parameter 
	dk_return ${_realpath_}; return			       		   # return value when using command substitution 
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	#dk_debugFunc 0
	
	realpathA=$(dk_realpath "DK.sh")
	dk_echo "realpathA = ${realpathA}"
	
	dk_realpath "DK.sh" realpathB
	dk_echo "realpathB = ${realpathB}"
	
	C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\usr\bin\cygpath.exe
}