#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


###############################################################################
# dkValidateArgs(...)
#
dk_validateArgs() {
	dk_debugFunc 1 99
	#dk_call dk_echo "$(__FILE__ 2):$(__LINE__ 2)  $(__FUNCTION__ 1)($(__ARGV__ 2))"
	#dk_call dk_echo "$(__FUNCTION__ 1)($(__ARGV__ 2))"
	#dk_call dk_echo "$(__FUNCTION__ 1)(${*})"
	
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
	
	#dk_call dk_echo "minArgs = ${minArgs}"
	#dk_call dk_echo "maxArgs = ${maxArgs}"
	#dk_call dk_echo "ARGC = ${ARGC}"
	
	[ ${ARGC} -lt ${minArgs} ] && dk_call dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): not enough arguments:(${ARGC}). The function is expecting at least ${minArgs} arguments"
	[ ${ARGC} -gt ${maxArgs} ] && dk_call dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): too many arguments:(${ARGC}). The function is expecting a max of ${maxArgs} arguments"
	[ ${n} -gt $((ARGC-1)) ] && return	
		
	for argType in "${@}"
	do	
		#dk_call dk_echo "n = ${n}"
		#dk_call dk_echo "minArgs = ${minArgs}"
		#dk_call dk_echo "maxArgs = ${maxArgs}"
		#dk_call dk_echo "ARGC = ${ARGC}"
		
		[ ${n} = ${ARGC} ] && continue #ARG${n} does not exist, so don't ask for it.
		local ARG=$(__ARG__ ${n} 2)
		#dk_call dk_echo "NEED${n}:${argType}  GOT${n}:${ARG}"
			
		  if [[ "$argType" =~ "args" ]]; then
			dk_call dk_echo "ARG${n} = ${argType}"	# TODO
		elif [[ "$argType" =~ "array" ]]; then
			$(dk_call dk_isArray $ARG) || dk_call dk_error "ARG${n}:'${ARG}' must be an array"
		elif [[ "$argType" =~ "element" ]]; then
			dk_call dk_echo "ARG${n} = ${argType}"	# TODO
		elif [[ "$argType" =~ "number" ]]; then
			$(dk_call dk_isNumber $ARG) || dk_call dk_error "ARG${n}:'${ARG}' must be a number"
		elif [[ "$argType" =~ "int" ]]; then
			dk_call dk_echo "ARG${n} = ${argType}"	# TODO
		elif [[ "$argType" =~ "string" ]]; then
			$(dk_call dk_isString $ARG) || dk_call dk_error "ARG${n}:'${ARG}' must be a string"
		elif [[ "$argType" =~ "rtn_var" ]]; then
			dk_call dk_echo "ARG${n} = ${argType}"   # TODO
		elif [[ "$argType" =~ "variable" ]]; then
			$(dk_call dk_isVariable $ARG) || dk_call dk_error "ARG${n}:'${ARG}' must be a variable"
		else
			dk_call dk_error "$argType is invalid. Acceptable types are ( args, array, element, int, string, rtn_var, variable, optional:args, optional:array, optional:int, optional:string, optional:rtn_var, variable )"
		fi
		
		n=$((n+1))
	done
	
	return $(true)
}




test_function() {
	dk_debugFunc
	dk_call dk_validateArgs number array string optional:int optional:array 
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myNumber=69
	myArray=(1 2 3)
	myString="string_value"
	
	test_function 69 myArray myString
	#test_function myNumber myArray			# NOT ENOUGH
	test_function 69 myArray myString an_optional
	test_function myNumber myArray myString TOO_MANY myArray
}
