# dk_include_guard()

##################################################################################
# dk_stacktrace()
#
#
dk_stacktrace () {
    dk_verbose "dk_stacktrace($*)"
	#[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	#[ "${LINENO-}" = "" ] || "LINENO = ${LINENO-}"	

	### VERSION 1 ###
	[ "${FUNCNAME-}" = "" ] && return 0
	#[ "${BASH_SOURCE-}" = "" ] && return 0
	#[ "${BASH_LINENO-}" = "" ] && return 0
	local i=${1:-1} size=${#FUNCNAME[@]}
 	((i<size)) && echo "STACKTRACE[$size]" 
	i=0
	while [ "$i" -le "$size" ]; do
		((frame=${#FUNCNAME[@]}-i-2 ))
		echo "[$frame] ${BASH_SOURCE[$i]:-}:${BASH_LINENO[$i]} ${FUNCNAME[$i+1]}()"
		i=$(( i + 1 ))
	done 


#	### VERSION 2 ###
#	[ "${FUNCNAME-}" = "" ] && return 0
#	[ "${BASH_SOURCE-}" = "" ] && return 0
#	[ "${BASH_LINENO-}" = "" ] && return 0
#	local status_code="${1}" 
#	local -a stack=("Stack trace of error code '${status_code}':")
#	local stack_size=${#FUNCNAME[@]}
#	local -i i
#	local indent="    "
#	# to avoid noise we start with 1 to skip the stack function
#	for (( i = 1; i < stack_size; i++ )); do
#	    local func="${FUNCNAME[$i]:-(top level)}"
#	    local -i line="${BASH_LINENO[$(( i - 1 ))]}"
#	    local src="${BASH_SOURCE[$i]:-(no file)}"
#	    stack+=("$indent └ $src:$line ($func)")
#	    indent="${indent}    "
#	done
#	(IFS=$'\n'; echo "${stack[*]}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller $i); do
#		echo >&2 [$i] $file:$line $func(): $(sed -n ${line}p $file)
#		((i++))
#	done
}