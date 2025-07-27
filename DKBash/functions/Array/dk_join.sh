#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH="$(dirname $(dirname $0))/DK.sh"                   && echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_arrayJoin(array, separator)
# dk_arrayJoin(array, separator, rtn_var)
#
#    The join() method of Array instances creates and returns a new string by concatenating all of the elements in this array, separated by commas or a specified separator string. 
#    If the array has only one item, then that item will be returned without using the separator.
#
#    PARAMETERS
#    separator :optional
#        A string to separate each pair of adjacent elements of the array. If omitted, the array elements are separated with a comma (",").
#
#    RETURN VALUE
#    A string with all array elements joined. If array.length is 0, the empty string is returned.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
dk_arrayJoin() {
	dk_call dk_echo "### dk_arrayJoin($*) ###";
	dk_debugFunc 2 3

	#_array_="";
	#unset _array_;
	#eval unset _array_;
	#unset arrayJoin;
	arrayJoin="";
	#eval unset arrayJoin;
	#export -n arrayJoin;
	#eval export -n arrayJoin;
	
	#dk_call dk_printVar _array_;
	#dk_call dk_debug "arrayJoin = '${arrayJoin-}'";
	#[ -n "${3-}" ] && dk_call dk_debug "${3-} = '${!3-}'";
	
	#typeset -n _array_=${1};
	eval local _array_='("${'${1}'[@]}")';		#typeset -n _array_=${1}
	#local arrayJoin="";
	
	for ((i=0; i < ${#_array_[@]}; i++ )); do
		[ ${i-} -gt 0 ] && arrayJoin+="${2-}";
		arrayJoin+="${_array_[${i-}]}";
	done
	export arrayJoin;
	
	###### return ######
	[ ${#} -gt 2 ] && eval ${3}='"${arrayJoin}"' || builtin echo "${arrayJoin}";
	#[ ${#} -gt 2 ] && eval ${3}='"${arrayJoin}"' || dk_return "${arrayJoin}";
	return $?;	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	myArrayA[0]="a b c";
	myArrayA[1]="1 2 3";
	myArrayA[2]="d e f";
	myArrayA[3]="4 5 6";
	myArrayA[4]="h i j";
	myArrayA[5]="7 8 9";
	dk_call dk_arrayJoin myArrayA "," myStringA;	
	dk_call dk_printVar myArrayA;
	dk_call dk_debug "arrayJoin = '${arrayJoin-}'";
	dk_call dk_debug "myStringA = '${myStringA-}'";
	
	
	
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_echo;
	myArrayB[0]="r s t";
	myArrayB[1]="4 5 6";
	myArrayB[2]="u v w";
	myArrayB[3]="x y z";
	dk_call dk_arrayJoin myArrayB ";" myStringB;
	dk_call dk_printVar myArrayB;
	dk_call dk_debug "arrayJoin = '${arrayJoin-}'";
	dk_call dk_debug "myStringB = '${myStringB-}'";
	
	
	
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_echo;
	myArrayC[0]="1 1 1";
	myArrayC[1]="z z z";
	myStringC=$(dk_call dk_arrayJoin myArrayC "_");
	dk_call dk_printVar myArrayC;
	#dk_call dk_debug "arrayJoin = '${arrayJoin-}'";
	dk_call dk_debug "myStringC = '${myStringC-}'";
}
