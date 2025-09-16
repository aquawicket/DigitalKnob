#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
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
# dk_arrayUnshift(array, element)
# dk_arrayUnshift(array, element, rtn_var)
#
#    Adds the specified elements to the beginning of an array and returns the new length of the array.
#
#    PARAMETERS
#    element1, …, elementN
#    The elements to add to the front of the arr.
#
#    RETURN VALUE
#    The new length property of the object upon which the method was called.
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
#
dk_arrayUnshift() {
	dk_debugFunc 2 99
	
	eval local array='("${'$1'[@]}")'					# typeset -n array=${1}
	array=("${@:2}" "${array[@]}");
	arrayUnshift="${#array[@]}";
	
	###### output ######
	export arrayUnshift;
	eval ${1}='("${array[@]}")';													# alter input variable
	#[ ${#} -gt 2 ] && eval ${3}=${_length_} || builtin echo "${arrayUnshift}";		# return value using return variable
	#[ ${#} -gt 2 ] && eval ${3}=${_length_} || dk_return "${arrayUnshift}";		# return value using command substitution
	return $?;					
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_arrayUnshift myArrayA "a b c" #lengthA
	dk_call dk_printVar myArrayA
	dk_call dk_debug "arrayUnshift = ${arrayUnshift-}"; 
	
	dk_call dk_arrayUnshift myArrayA "1 2 3" #lengthA
	dk_call dk_printVar myArrayA
	dk_call dk_debug "arrayUnshift = ${arrayUnshift}"; 
	
	dk_call dk_arrayUnshift myArrayA "d e f" #lengthA
	dk_call dk_printVar myArrayA
	dk_call dk_debug "arrayUnshift = ${arrayUnshift}"; 
	
	dk_call dk_arrayUnshift myArrayA "4 5 6" #lengthA
	dk_call dk_printVar myArrayA
	dk_call dk_debug "arrayUnshift = ${arrayUnshift}"; 
	
	dk_call dk_arrayUnshift myArrayA "h i j" #lengthA
	dk_call dk_printVar myArrayA
	dk_call dk_debug "arrayUnshift = ${arrayUnshift}"; 
	
	
#	# FIXME: command substitution cannot alter parent variables
#	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "h i j")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "4 5 6")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "d e f")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "1 2 3")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "a b c")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
}
