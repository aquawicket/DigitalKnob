#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


###############################################################################
# dkValidateArgs(...)
#
dk_validateArgs (){
	dk_debugFunc
	dk_echo "$(__FILE__ 2):$(__LINE__ 2)  $(__FUNCTION__ 1)($(__ARGV__ 2))"
	
	local minArgs=${#}
	local count=0
	for arg in "$@"
	do
		dk_echo "count = $count"
		dk_echo "ARGV = $(__ARGV__ 2)"
		dk_echo "ARG${count} = $(__ARG__ ${count} 2)"
		if [ $arg = "args" ]; then
			local maxArgs=99
		elif [ $arg = "array" ]; then
			#dk_isArray $arg
			local maxArgs=${#}
		elif [ $arg = "element" ]; then
			local maxArgs=${#}
		elif [ $arg = "int" ]; then
			local maxArgs=${#}
		elif [ $arg = "string" ]; then
			local maxArgs=${#}
		elif [ $arg = "rtn_var" ]; then
			local maxArgs=${#}
		elif [ $arg = "variable" ]; then
			local maxArgs=${#}
		elif [ $arg = "optional:args" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=99
		elif [ $arg = "optional:array" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:element" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:int" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:string" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:rtn_var" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:variable" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		else
			dk_error "$arg is invalid. Acceptable types are ( args, array, element, int, string, rtn_var, variable, optional:args, optional:array, optional:int, optional:string, optional:rtn_var, variable )"
		fi
			count=$((count+1))
	done
	
	local ARGC=$(__ARGC__ 2)
	[ ${ARGC} -lt ${minArgs} ] && dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): not enough arguments:(${ARGC}). The function is expecting at least ${minArgs} arguments"
	[ ${ARGC} -gt ${maxArgs} ] && dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): too many arguments:(${ARGC}). The function is expecting a max of ${maxArgs} arguments"
	
	return ${true}
}






#DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
#	dk_debugFunc
#	
#	dk_validateArgs
#}
