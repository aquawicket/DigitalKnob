#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayAt(array, index)
# dk_arrayAt(array, index, rtn_var)
#
#	The dk_arrayAt method takes an array instance with an integer value and returns the item at that index, 
#	allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
dk_arrayAt() {
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 3 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array int optional:rtn_var
	
	eval local arrayAt='("${'${1}'[${2}]}")'
	
	### return value ###
	[ ${#} -gt 2 ] && eval ${3}='"${arrayAt}"' && return	# return value using return variable
	dk_return "${arrayAt}" && return						# return value using command substitution
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayB[0]="a b c"
	myArrayB[1]="1 2 3"
	myArrayB[2]="d e f"
	myArrayB[3]="4 5 6"
	myArrayB[4]="h i j"
	dk_arrayAt myArrayB 2 arrayAt2	# returned value using return variable
	dk_printVar arrayAt2
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	arrayAt3=$(dk_arrayAt myArrayA 3)	# returned value using command substitution
	dk_printVar arrayAt3
}
