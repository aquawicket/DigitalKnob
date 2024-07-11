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
dk_arrayAt (){
	dk_debugFunc
	#[ ${#} -ne 3 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	dk_validateArgs array int optional:rtn_var
	
	#eval local arry=('${'$1'[@]}')
	typeset -n arry=${1}
	
	local arrayAt="${arry[${2}]}"
	dk_printVar arrayAt
	
	# return value
	[ ${#} -gt 2 ] && eval "${3}=${arrayAt}"	# return using parameter rtn_var
	dk_return ${arrayAt}; return				# return through command substitution 
}






DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArrayA[0]="a"
	myArrayA[1]="b"
	myArrayA[2]="c"
	myArrayA[3]="d"
	myArrayA[4]="e"
	
	elementA=$(dk_arrayAt myArrayA 3)	# return through command substitution 
	dk_echo "elementA = ${elementA}"
	
	
	
	myArrayB[0]="1"
	myArrayB[1]="2"
	myArrayB[2]="3"
	myArrayB[3]="4"
	myArrayB[4]="5"
	
	dk_arrayAt myArrayB 3 elementB		# return using third parameter rtn_var
	dk_echo "elementB = ${elementB}"
}
