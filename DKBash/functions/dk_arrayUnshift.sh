#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
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
	
	eval local array='("${'$1'[@]}")'
	local rtn_var="dk_arrayUnshift"
	
	array=("${@:2}" "${array[@]}");
	local _arrayUnshift=${#array[@]}
	
	###### output ######
	eval ${1}='("${array[@]}")'						
	eval ${rtn_var}='${_arrayUnshift}'		# return value in FUNCTION_NAME or RETURN_VAR
	dk_return "${_arrayUnshift}"			# FIXME: command substitution cannot alter parent variables
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_arrayUnshift myArray "a b c"
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayUnshift
	
	dk_call dk_echo
	dk_call dk_arrayUnshift myArray "1 2 3"
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayUnshift
	
	dk_call dk_echo
	dk_call dk_arrayUnshift myArray "d e f"
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayUnshift
	
	dk_call dk_echo
	dk_call dk_arrayUnshift myArray "4 5 6"
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayUnshift
	
	dk_call dk_echo
	dk_call dk_arrayUnshift myArray "h i j"
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayUnshift
	
	# FIXME: command substitution cannot alter parent variables
#	new_lengthB=$(dk_call dk_arrayUnshift myArray "h i j")
#	dk_call dk_printVar myArray
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArray "4 5 6")
#	dk_call dk_printVar myArray
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArray "d e f")
#	dk_call dk_printVar myArray
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArray "1 2 3")
#	dk_call dk_printVar myArray
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayUnshift myArray "a b c")
#	dk_call dk_printVar myArray
#	dk_call dk_printVar new_lengthB
}
