#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


###############################################################################
# dkValidateArgs(...)
#
dk_validateArgs() {
	dk_debugFunc
	#dk_echo "$(__FILE__ 2):$(__LINE__ 2)  $(__FUNCTION__ 1)($(__ARGV__ 2))"
	#dk_echo "$(__FUNCTION__ 1)($(__ARGV__ 2))"
	#dk_echo "$(__FUNCTION__ 1)(${*})"
	
	local ARGC=$(__ARGC__ 2)
	local n=0
	local minArgs=${#}
	local maxArgs=${#}
	
	for argType in "${@}"
	do
		if [[ "$argType" =~ "optional:" ]]; then
			minArgs=$((minArgs-1))
		fi
		if [[ "$argType" =~ "args" ]]; then
			maxArgs=99
		fi
	done
	
	#dk_echo "minArgs = ${minArgs}"
	#dk_echo "maxArgs = ${maxArgs}"
	#dk_echo "ARGC = ${ARGC}"
	
	[ ${ARGC} -lt ${minArgs} ] && dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): not enough arguments:(${ARGC}). The function is expecting at least ${minArgs} arguments"
	[ ${ARGC} -gt ${maxArgs} ] && dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): too many arguments:(${ARGC}). The function is expecting a max of ${maxArgs} arguments"
	[ ${n} -gt $((ARGC-1)) ] && return	
		
	for argType in "${@}"
	do	
		#dk_echo "n = ${n}"
		#dk_echo "minArgs = ${minArgs}"
		#dk_echo "maxArgs = ${maxArgs}"
		#dk_echo "ARGC = ${ARGC}"
		
		[ ${n} = ${ARGC} ] && continue #ARG${n} does not exist, so don't ask for it.
		local ARG=$(__ARG__ ${n} 2)
		#dk_echo "NEED${n}:${argType}  GOT${n}:${ARG}"
			
		  if [[ "$argType" =~ "args" ]]; then
			dk_echo "ARG${n} = ${argType}"	# TODO
		elif [[ "$argType" =~ "array" ]]; then
			$(dk_isArray $ARG) || dk_error "ARG${n}:'${ARG}' must be an array"
		elif [[ "$argType" =~ "element" ]]; then
			dk_echo "ARG${n} = ${argType}"	# TODO
		elif [[ "$argType" =~ "number" ]]; then
			$(dk_isNumber $ARG) || dk_error "ARG${n}:'${ARG}' must be a number"
		elif [[ "$argType" =~ "int" ]]; then
			dk_echo "ARG${n} = ${argType}"	# TODO
		elif [[ "$argType" =~ "string" ]]; then
			$(dk_isString $ARG) || dk_error "ARG${n}:'${ARG}' must be a string"
		elif [[ "$argType" =~ "rtn_var" ]]; then
			dk_echo "ARG${n} = ${argType}"   # TODO
		elif [[ "$argType" =~ "variable" ]]; then
			$(dk_isVariable $ARG) || dk_error "ARG${n}:'${ARG}' must be a variable"
		else
			dk_error "$argType is invalid. Acceptable types are ( args, array, element, int, string, rtn_var, variable, optional:args, optional:array, optional:int, optional:string, optional:rtn_var, variable )"
		fi
		
		n=$((n+1))
	done
	
	return ${true}
}




test_function() {
	dk_debugFunc
	
	dk_validateArgs number array string optional:int optional:array 
}

DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myNumber=69
	myArray=(1 2 3)
	myString="string_value"
	
	test_function 69 myArray myString
	#test_function myNumber myArray			# NOT ENOUGH
	test_function 69 myArray myString an_optional
	test_function myNumber myArray myString TOO_MANY myArray
}
