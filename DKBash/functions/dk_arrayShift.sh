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
# dk_arrayShift(array)
# dk_arrayShift(array, rtn_var)
#
#	 Removes the first element from an array and returns that removed element. 
#    This method changes the length of the array.
#
#    PARAMETERS
#    array
#
#    RETURN VALUE
#    The removed element from the array; undefined if the array is empty.
#    
#    REFERENCE
#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
#
dk_arrayShift() {
	dk_debugFunc 1 2
	#dk_call dk_validateArgs array
	
	eval local array='("${'$1'[@]}")'						#typeset -n array=${1}
	local rtn_var="dk_arrayShift"
	
	eval local _arrayShift='("${'array'[0]}")'
	array=("${array[@]:1}")
	
	###### output ######
	eval ${1}='("${array[@]}")'
	eval ${rtn_var}='("${_arrayShift[@]}")'		# return value in FUNCTION_NAME or RETURN_VAR
	
	# FIXME: command substitution cannot alter parent variables
	dk_return "${_arrayShift}" 					# return value using command substitution
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
	
	dk_call dk_echo
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayShift
	
	dk_call dk_echo
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayShift
	dk_call dk_echo
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayShift
	dk_call dk_echo
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayShift
	dk_call dk_echo
	
	dk_call dk_arrayShift myArray
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayShift
	dk_call dk_echo
	
	# FIXME:  out of array bounds past here
	#dk_call dk_arrayShift myArray
	#dk_call dk_printVar myArray
	#dk_call dk_printVar dk_arrayShift
	#dk_call dk_echo
	
	
	
	# FIXME: command substitution cannot alter parent variables
#	myArray[0]="h i j"
#	myArray[1]="4 5 6"
#	myArray[2]="d e f"
#	myArray[3]="1 2 3"
#	myArray[4]="a b c"
#	dk_call dk_printVar myArray
#	
#	dk_call dk_echo
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	
#	dk_call dk_echo
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#
#	dk_call dk_echo
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	
#	dk_call dk_echo
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	
#	dk_call dk_echo
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	
#	# FIXME:  out of array bounds past here
#	dk_call dk_echo
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
}
