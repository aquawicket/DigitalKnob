#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_stacktrace()
#
#
dk_stacktrace() {
    dk_debugFunc 0
	#ENABLE_dk_debugFunc=0

	### VERSION 1 ###
	stack_size=${#FUNCNAME[@]}
	dk_echo "STACKTRACE[${stack_size}]" 
	local i=0
	while [ "${i}" -lt "${stack_size}" ]; do
		i=$(( i + 1 ))
		frame=$(( i - 2 ))
		if [ ${i} -eq 2 ]; then
			fileline=$(sed -n ${BASH_LINENO[${i}-1]-}p ${BASH_SOURCE[${i}]:-})
			dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${bg_white-}${black-}${BASH_LINENO[${i}-1]-}: > ${fileline}${clr-}"
			continue
		fi
		[ ${i} -gt 2 ] && dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${BASH_LINENO[${i}-1]-} ${FUNCNAME[${i}-1]-}()" # && continue
	done 


#	### VERSION 2 ###
#	[ "${FUNCNAME-}" = "" ] && return 0
#	[ "${BASH_SOURCE-}" = "" ] && return 0
#	[ "${BASH_LINENO-}" = "" ] && return 0
#	local status_code="${1-}" 
#	local -a stack=("Stack trace of error code '${status_code}':")
#	local stack_size=${#FUNCNAME[@]}
#	local -i i
#	local indent="    "
#	# to avoid noise we start with 1 to skip the stack function
#	for (( i = 1; i < stack_size; i++ )); do
#	    local func="${FUNCNAME[${i}]:-(top level)}"
#	    local -i line="${BASH_LINENO[$(( i - 1 ))]}"
#	    local src="${BASH_SOURCE[${i}]:-(no file)}"
#	    stack+=("${indent} └ ${src}:${line} (${func})")
#	    indent="${indent}    "
#	done
	(IFS=$'\n'; echo "${stack[*]-}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller ${i}); do
#		echo >&2 [${i}] ${file}:${line} ${func}(): $(sed -n ${line}p ${file})
#		((i++))
#	done
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_stacktrace
}