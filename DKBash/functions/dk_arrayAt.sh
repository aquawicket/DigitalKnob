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
	#[ ${#} -ne 3 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	dk_validateArgs array int optional:rtn_var
	
	eval local arrayAt='("${'${1}'[${2}]}")'
	dk_printVar arrayAt
	
	### return value ###
	[ ${#} -gt 2 ] && eval '${3}="${arrayAt}"' && return	# return value when using rtn_var parameter 
	dk_return "${arrayAt}"; return						# return value when using command substitution
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	arrayAt3=$(dk_arrayAt myArrayA 3)	# return value when using command substitution
	dk_printVar arrayAt3
	
	
	
	myArrayB[0]="a b c"
	myArrayB[1]="1 2 3"
	myArrayB[2]="d e f"
	myArrayB[3]="4 5 6"
	myArrayB[4]="h i j"
	
	dk_arrayAt myArrayB 2 arrayAt2		# return value when using rtn_var parameter 
	dk_printVar arrayAt2
}
