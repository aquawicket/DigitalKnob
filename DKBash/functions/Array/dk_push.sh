#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH="$(dirname $(dirname $0))/DK.sh"                   && echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    The push() method of Array instances adds the specified elements to the end of an array and returns the new length of the array.
#
#    PARAMETERS
#    element1, …, elementN
#        The element(s) to add to the end of the array.
#
#    RETURN VALUE
#    The new length property of the object upon which the method was called.
#
#    REFERENCE
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
dk_arrayPush() {
	dk_debugFunc 2 99
	#dk_call dk_validateArgs array element optional:rtn_var
	
	eval local array='("${'$1'[@]}")'	#typeset -n array=${1}
	array=("${array[@]}" "${@:2}");
	
	# FIXME: the new array does not get assigned in command substitution.
	# i.e.  new_length=$(dk_arrayPush myArray "new item") 

	### return value ###
	# FIXME: new arrays do not get assigned in command substitution.
	eval ${1}='("${array[@]}")';						# alter input variable
	#[ ${#} -gt 2 ] && eval ${3}=${#array[@]} && return	# variable parameter return	
	dk_return ${#array[@]} && return;					# command substitution return
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_arrayPush myArrayA "a b c" # new_lengthA
	dk_call dk_printVar myArrayA
	# dk_call dk_printVar new_lengthA
	
	dk_call dk_arrayPush myArrayA "1 2 3" "d e f" # new_lengthA
	dk_call dk_printVar myArrayA
	# dk_call dk_printVar new_lengthA
	
	dk_call dk_arrayPush myArrayA "4 5 6" "h i j" # new_lengthA
	dk_call dk_printVar myArrayA
	# dk_call dk_printVar new_lengthA
	
	
	
	# FIXME: the new array does not get assigned in command substitution.
#	new_lengthB=$(dk_call dk_arrayPush 'myArrayB' "h i j")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayPush 'myArrayB' "4 5 6" "d e f")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
#	
#	new_lengthB=$(dk_call dk_arrayPush 'myArrayB' "1 2 3" "a b c")
#	dk_call dk_printVar myArrayB
#	dk_call dk_printVar new_lengthB
}