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
# dk_toLower(<input> <rtn_var:OPTIONAL>)
#
#
dk_toLower() {
	dk_debugFunc 1 2
	
	#_toLower=${1,,}  # bash 4.0+
	dk_toLower=$(builtin echo "${1}" | tr '[:upper:]' '[:lower:]');
	

	###### output ######
	export dk_toLower=${dk_toLower};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_toLower};
	else
		builtin echo "${dk_toLower}";
	fi
	return $?;
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	### Special Characters ###
	#     ALL:  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
	#   VALID:  !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _   { | } ~
	# INVALID:    "                                                   `        
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_toLower "A:/directoryA/filenameA.extA";
	dk_call dk_echo "dk_toLower = ${dk_toLower}";
	
	### Result as parameter
	dk_call dk_echo;
	dk_call dk_toLower "B:/directoryB/filenameB.extB" resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_toLower = ${dk_toLower}";
	
	### Result as return value
	dk_call dk_echo;
	resultC=$(dk_call dk_toLower "C:/directoryC/filenameC.extC");
	dk_call dk_echo "resultC = ${resultC}";
	#dk_call dk_echo "dk_toLower = ${dk_toLower}";					#NOTE: export cannot be seen outside of command substituion
}
