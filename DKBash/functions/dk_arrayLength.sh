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


################################################################################
# dk_arrayLength(array)
# dk_arrayLength(array, rtn_var)
#
#    The length data property of an Array instance represents the number of elements in that array. 
#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
#
dk_arrayLength() {
	dk_debugFunc 1 2;
	
	eval local array='("${'$1'[@]}")';		#typeset -n array=${1}	
	[ -n "${2-}" ] && local rtn_var="${2}" || local rtn_var="dk_arrayLength";
	
	dk_arrayLength=${#array[@]};
	
	###### output ######
	export dk_arrayLength=${dk_arrayLength};
	if [ -n "${2-}" ]; then
		export ${2}=${dk_arrayLength};
	else
		builtin echo "${dk_arrayLength}";
	fi
	return $?;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray[0]="a b c"
	myArray[1]="1 2 3"
	myArray[2]="d e f"
	myArray[3]="4 5 6"
	myArray[4]="h i j"
	dk_call dk_printVar myArray
	
	
	### Result as global variable
	dk_call dk_echo;
	dk_call dk_arrayLength myArray;
	dk_call dk_echo "dk_arrayLength = ${dk_arrayLength}";
	
	### Result as parameter
	dk_call dk_echo;
	dk_call dk_arrayLength myArray resultB;
	dk_call dk_echo "resultB = ${resultB}";
	dk_call dk_echo "dk_arrayLength = ${dk_arrayLength}";
	
	### Result as return value
	dk_call dk_echo;
	resultC=$(dk_call dk_arrayLength myArray);
	dk_call dk_echo "resultC = ${resultC}";
	#dk_call dk_echo "dk_arrayLength = ${dk_arrayLength}";					#NOTE: export cannot be seen outside of command substituion
}
