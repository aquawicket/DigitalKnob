#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


###############################################################################
# dkValidateArgs(...)
#
dk_validateArgs (){
	dk_debugFunc
	#dk_echo "$(__FILE__ 2):$(__LINE__ 2)  $(__FUNCTION__ 1)($(__ARGV__ 2))"
	
	local minArgs=${#}
	for arg in "$@"
	do
		if [ $arg = "args" ]; then
			#local argType="args"
			local maxArgs=99
		elif [ $arg = "array" ]; then
			#local argType="array"
			local maxArgs=${#}
		elif [ $arg = "element" ]; then
			#local argType="element"
			local maxArgs=${#}
		elif [ $arg = "int" ]; then
			#local argType="int"
			local maxArgs=${#}
		elif [ $arg = "string" ]; then
			#local argType="string"
			local maxArgs=${#}
		elif [ $arg = "rtn_var" ]; then
			#local argType="rtn_var"
			local maxArgs=${#}
		elif [ $arg = "variable" ]; then
			#local argType="variable"
			local maxArgs=${#}
		elif [ $arg = "optional:args" ]; then
			#local argType="optional:args"
			local minArgs=$((minArgs-1))
			local maxArgs=99
		elif [ $arg = "optional:array" ]; then
			#local argType="optional:array"
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:element" ]; then
			#local argType="optional:element"
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:int" ]; then
			#local argType="optional:int"
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:string" ]; then
			#local argType="optional:string"
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:rtn_var" ]; then
			#local argType="optional:rtn_var"
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		elif [ $arg = "optional:variable" ]; then
			#local argType="optional:variable"
			local minArgs=$((minArgs-1))
			local maxArgs=${#}
		else
			dk_error "$arg is invalid. Acceptable types are ( args, array, int, string, rtn_var, variable, optional:args, optional:array, optional:int, optional:string, optional:rtn_var, variable )"
		fi
			#dk_echo "$arg"
	done
	
	local ARGC=$(__ARGC__ 2)
	[ ${ARGC} -lt ${minArgs} ] && dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): not enough arguments:(${ARGC}). The function is expecting at least ${minArgs} arguments"
	[ ${ARGC} -gt ${maxArgs} ] && dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): too many arguments:(${ARGC}). The function is expecting a max of ${maxArgs} arguments"
}






#DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
#	dk_debugFunc
#	
#	dk_validateArgs
#}
