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
# dk_basename(path, rtn_var)
#
#	https://en.wikipedia.org/wiki/Basename
#
dk_basename() {
	dk_debugFunc 1 2
	
	#local dk_basename=$(basename "${1}")
	dk_basename=$(basename "${1}")

	### return value ###
	#dk_call dk_printVar dk_basename 	# ERROR: causes infinate loop
	[ ${#} -gt 1 ] && eval "${2}=${dk_basename}" && return $?	# return value when using rtn_var parameter 
	dk_return ${dk_basename}; return	$?				      	# return value when using command substitution
	
#DEBUG
#	dk_call dk_printVar dk_basename
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_basename "/path/to/a/filenameA.txt"
	dk_call dk_echo "dk_basename = ${dk_basename}"
	
	basenameB=$(dk_call dk_basename "/path/to/a/filenameB.txt")
	dk_call dk_echo "basenameB = ${basenameB}"
	
	dk_call dk_basename "/path/to/a/filenameC.txt" basenameC
	dk_call dk_echo "basenameC = ${basenameC}"
	
	dk_call dk_basename "/path/to/a/filenameD.txt" basenameD
	dk_call dk_echo "dk_basename = ${dk_basename}"
	dk_call dk_echo "basenameD = ${basenameD}"
}
