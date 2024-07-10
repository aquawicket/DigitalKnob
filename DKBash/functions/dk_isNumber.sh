#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##############################################################################
# dk_isNumber(arg) -> rtn_var
# 
#	Test if arg1 is a number or a number variable
#
#	${1}			- The variable to test
#	${rtn_var}: 	- True if the argument is string or a string variable
#
dk_isNumber (){
	dk_debugFunc 
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	re='^[0-9]+$'
	dk_isVariable ${1} && local var=${!1} || local var=${1}

	[[ ${var} =~ ${re} ]] && return $(true) || return $(false)
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	myNumber1=69
	dk_isNumber myNumber1 && echo "myNumber1 is a number" || echo "myNumber1 is NOT a number"
	dk_isNumber 23        && echo "23 is a number"        || echo "23 is NOT a number"
	dk_isNumber 123.456   && echo "123.456 is a number"   || echo "123.456 is NOT a number"
	dk_isNumber 0         && echo "0 is a number"         || echo "0 is NOT a number"
	dk_isNumber 1         && echo "1 is a number"         || echo "1 is NOT a number"
	
	#dk_echo "dk_isNumber myNumber1 = $(dk_isNumber myNumber1)"
	
	#if dk_isNumber myNumber1; then
	#	echo "myNumber1 is a number"
	#else
	#	echo "myNumber1 is NOT a number"
	#fi
}
