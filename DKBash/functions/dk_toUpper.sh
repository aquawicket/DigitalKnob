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
# dk_toUpper(<input> <rtn_var:OPTIONAL>)
#
#
dk_toUpper() {
	dk_debugFunc 1 2

	#dk_toUpper=${1^^};  # bash 4.0+
	dk_toUpper=$(builtin echo "${1}" | tr '[:lower:]' '[:upper:]');
	
	
	### return value ###
	export dk_toUpper=${dk_toUpper};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_toUpper};
	else
		builtin echo "${dk_toUpper}";
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
	dk_call dk_echo
	myVar="a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ! # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ { | } ~"
	dk_call dk_printVar myVar
	
	# return value in FUNCTION_NAME
	dk_call dk_echo
	dk_call dk_toUpper "${myVar}"					
	dk_call dk_printVar dk_toUpper
	
	# return value in RETURN_VAR
	dk_call dk_echo
	dk_call dk_toUpper "${myVar}" rv_toUpper		
	dk_call dk_printVar rv_toUpper
	
	# return value in COMMAND_SUBSTITUTION
	dk_call dk_echo
	cs_toUpper=$(dk_call dk_toUpper "${myVar}")		
	dk_call dk_printVar cs_toUpper
}