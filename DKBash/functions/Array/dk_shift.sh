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
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	eval local removedElement='("${'array'[0]}")'
	array=("${array[@]:1}")
	
	###### output ######
	# FIXME: command substitution cannot alter parent variables
	eval ${1}='("${array[@]}")'																	# alter the original variable
	[ ${#} -gt 1 ] && eval ${2}='"${removedElement}"' || builtin echo "${removedElement}";
	#[ ${#} -gt 1 ] && eval ${2}='"${removedElement}"' || dk_return "${removedElement}";		# return value using command substitution
	return $?;				
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	dk_call dk_printVar myArrayA
	dk_call dk_echo
	
	dk_call dk_arrayShift myArrayA removedA
	dk_call dk_printVar myArrayA
	dk_call dk_printVar removedA
	dk_call dk_echo
	
	dk_call dk_arrayShift myArrayA removedA
	dk_call dk_printVar myArrayA
	dk_call dk_printVar removedA
	dk_call dk_echo
	
	dk_call dk_arrayShift myArrayA removedA
	dk_call dk_printVar myArrayA
	dk_call dk_printVar removedA
	dk_call dk_echo
	
	dk_call dk_arrayShift myArrayA removedA
	dk_call dk_printVar myArrayA
	dk_call dk_printVar removedA
	dk_call dk_echo
	
	dk_call dk_arrayShift myArrayA removedA
	dk_call dk_printVar myArrayA
	dk_call dk_printVar removedA
	dk_call dk_echo
	
	# FIXME:  out of array bounds past here
#	dk_call dk_arrayShift myArrayA removedA
#	dk_call dk_printVar myArrayA
#	dk_call dk_printVar removedA
	dk_call dk_echo
	dk_call dk_echo
	
	
	
#	# FIXME: command substitution cannot alter parent variables
#	myArrayB[0]="h i j"
#	myArrayB[1]="4 5 6"
#	myArrayB[2]="d e f"
#	myArrayB[3]="1 2 3"
#	myArrayB[4]="a b c"
#	
#	dk_call dk_printVar myArrayB 
#	dk_call dk_echo
#	
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
#	
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
#	
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
#	
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
#	
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
#	
#	# FIXME:  out of array bounds past here
#	removedB=$(dk_call dk_arrayShift myArrayB)
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar removedB
#	dk_call dk_echo
}
