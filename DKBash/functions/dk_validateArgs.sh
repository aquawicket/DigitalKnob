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
	for argType in "$@"
	do
		#dk_echo "ARGV = $(__ARGV__ 2)"
		#dk_echo "ARG${count} = $(__ARG__ ${count} 2)"
		ARG=$(__ARG__ ${count} 2)
		
		if [ $argType = "args" ]; then
			local maxArgs=99
		elif [ $argType = "array" ]; then
			#$(dk_isArray $ARG) && dk_info "ARG${count}:'${ARG}' is an array" || dk_error "ARG${count}:'${ARG}' must be an array"
			$(dk_isArray $ARG) || dk_error "ARG${count}:'${ARG}' must be an array"
			local maxArgs=${#}
		elif [ $argType = "element" ]; then
			local maxArgs=${#}
		elif [ $argType = "int" ]; then
			local maxArgs=${#}
		elif [ $argType = "string" ]; then
			local maxArgs=${#}
		elif [ $argType = "rtn_var" ]; then
			local maxArgs=${#}
		elif [ $argType = "variable" ]; then
			local maxArgs=${#}
		elif [ $argType = "optional:args" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=99
		elif [ $argType = "optional:array" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $argType = "optional:element" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $argType = "optional:int" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $argType = "optional:string" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $argType = "optional:rtn_var" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $argType = "optional:variable" ]; then
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		else
			dk_error "$argType is invalid. Acceptable types are ( args, array, element, int, string, rtn_var, variable, optional:args, optional:array, optional:int, optional:string, optional:rtn_var, variable )"
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
