#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)									&& echo "bash_exe = ${bash_exe}"
	[ -e "${DK_SH}" ]                  || export DK_SH="$(dirname $(dirname $0))/DK.sh"                   && echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_arrayIndexOf(array, searchElement)
# dk_arrayIndexOf(array, searchElement, rtn_val)
# dk_arrayIndexOf(array, searchElement, fromIndex)
# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_val)
#
#    The indexOf() method of Array instances returns the first index at which a given element can be found in the array, or -1 if it is not present.
#
#    PARAMETERS
#    searchElement
#        Element to locate in the array.
#
#    fromIndex :optional
#        Zero-based index at which to start searching, converted to an integer.
#            Negative index counts back from the end of the array — if -array.length <= fromIndex < 0, fromIndex + array.length is used. 
#            Note, the array is still searched from front to back in this case.
#            If fromIndex < -array.length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
#            If fromIndex >= array.length, the array is not searched and -1 is returned.
#
#    RETURN VALUE
#    The first index of searchElement in the array; -1 if not found.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
dk_arrayIndexOf() {
	dk_debugFunc 2 4
	
	unset arrayIndexOf;
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	for ((i=0; i < ${#array[@]}; i++ )); do
		if [ "${2}" = "${array[${i}]}" ]; then
			arrayIndexOf=${i};
			export arrayIndexOf;
			[ ${#} -gt 2 ] && eval ${3}=${arrayIndexOf} || builtin echo "${arrayIndexOf}";
			#[ ${#} -gt 2 ] && eval ${3}=${arrayIndexOf} || dk_return ${arrayIndexOf};
			return;
		fi
	done
	
	arrayIndexOf=-1
	[ ${#} -gt 2 ] && eval ${3}=${arrayIndexOf} || builtin echo "${arrayIndexOf}";
	#[ ${#} -gt 2 ] && eval ${3}=${arrayIndexOf} || dk_return ${arrayIndexOf};
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
	
	dk_call dk_arrayIndexOf myArrayA "a b c" indexABC;
	dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexABC = ${indexABC}";
	
	dk_call dk_arrayIndexOf myArrayA "1 2 3" index123;
	dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "index123 = ${index123}";
	
	dk_call dk_arrayIndexOf myArrayA "d e f" indexDEF;
	dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexDEF = ${indexDEF}";
	
	dk_call dk_arrayIndexOf myArrayA "4 5 6" index456;
	dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "index456 = ${index456}";
	
	dk_call dk_arrayIndexOf myArrayA "h i j" indexHIJ;
	dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexHIJ = ${indexHIJ}";
	
	dk_call dk_arrayIndexOf myArrayA "nonExistant" indexN;
	dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexN = ${indexN}";
	
	
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_echo;
	myArrayB[0]="h i j";
	myArrayB[1]="4 5 6";
	myArrayB[2]="d e f";
	myArrayB[3]="1 2 3";
	myArrayB[4]="a b c";
	
	indexABC2=$(dk_call dk_arrayIndexOf myArrayB "a b c");
	#dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexABC2 = ${indexABC2}";
	
	index123B=$(dk_call dk_arrayIndexOf myArrayB "1 2 3");
	#dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "index123B = ${index123B}";
	
	indexDEF2=$(dk_call dk_arrayIndexOf myArrayB "d e f");
	#dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexDEF2 = ${indexDEF2}";
	
	index456B=$(dk_call dk_arrayIndexOf myArrayB "4 5 6");
	#dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "index456B = ${index456B}";
	
	indexHIJ2=$(dk_call dk_arrayIndexOf myArrayB "h i j");
	#dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexHIJ2 = ${indexHIJ2}";
	
	indexNN=$(dk_call dk_arrayIndexOf myArrayB "nonExistant");
	#dk_call dk_debug "arrayIndexOf = ${arrayIndexOf}";
	dk_call dk_debug "indexNN = ${indexNN}";
}
