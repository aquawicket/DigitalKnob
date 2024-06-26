#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##############################################################################
# dk_isFunction(name rtn_var)
# 
#	Test if a string is a function name
#
#	@name	- The name to test
#	@rtn_var: 	- True if the string is the name of a function, False if otherwise.
#
#	https://stackoverflow.com/a/85932/688352
#
dk_isFunction (){
	dk_debugFunc 
	
	if declare -F "$1" > /dev/null; then 
		isFunction=1
		eval $2="${isFunction-}"
		dk_printVar isFunction
		[ ${isFunction-} -eq 1 ]
	else 
		isFunction=0
		eval $2="${isFunction-}"
		dk_printVar isFunction
		[ ${isFunction-} -eq 1 ]
	fi
}



test_function (){
	dk_info "..."
}

DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	dk_echo "testing dk_isFunction(test_function)"
	dk_isFunction "test_function" isFunction
	dk_info "isFunction = ${isFunction}"
	$(dk_isFunction "test_function") && echo "true" || echo "false"
	
	dk_echo "testing dk_isFunction(nonExistentFunction)" 
	dk_isFunction "nonExistentFunction" isFunction
	dk_info "isFunction = ${isFunction}"
	$(dk_isFunction "nonExistentFunction") && echo "true" || echo "false"
}
