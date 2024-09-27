#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


##################################################################################
# dk_stacktrace()
#
#
function(dk_stacktrace)
    dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	string(TIMESTAMP __TIME__ "%M:%S:%f")
	string(SUBSTRING "${__TIME__}" 0 10 __TIME__)
	list(PREPEND CMAKE_TIME ${__TIME__})
	list(PREPEND CMAKE_SOURCE ${CMAKE_CURRENT_FUNCTION_LIST_FILE})
	list(PREPEND CMAKE_LINENO ${CMAKE_CURRENT_FUNCTION_LIST_LINE})
	list(APPEND FUNCNAME "main")
	list(APPEND STACK_LEVEL 0)
	
	### VERSION 1 ###
	list(LENGTH FUNCNAME stack_size)
	dk_echo("STACKTRACE[${stack_size}]")
	set(n 0)
	#foreach(frame ${FUNCNAME})
	while(${n} LESS ${stack_size})
		list(GET CMAKE_TIME ${n} _TIME_)
		list(GET CMAKE_SOURCE ${n} _FILE_)
		list(GET CMAKE_LINENO ${n} _LINE_)
		list(GET FUNCNAME ${n} _FUNCTION_)
		list(GET STACK_LEVEL ${n} _LEVEL_)
			
			unset(indent)
			set(i 4)
			while(${i} LESS ${_LEVEL_})
				set(indent "${indent}   ")
				math(EXPR i "${i}+1")
			endwhile(${i} LESS ${_LEVEL_})
		set(indent "${indent} L ")
		
		
		dk_echo("${cyan}[${_TIME_}]${indent} ${_FILE_}:${_LINE_}   ${blue}${_FUNCTION_}()")
		math(EXPR n "${n}+1")
	endwhile()

#	while [ "${i}" -lt "${stack_size}" ]; do
#		i=$(( i + 1 ))
#		frame=$(( i - 2 ))
#		if [ $i -eq 2 ]; then
#			fileline=$(sed -n ${BASH_LINENO[${i}-1]-}p ${BASH_SOURCE[${i}]:-})
#			dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${bg_white-}${black-}${BASH_LINENO[${i}-1]-}: > ${fileline}${clr-}"
#			continue
#		fi
#		[ $i -gt 2 ] && dk_echo "  [${frame}] ${BASH_SOURCE[${i}]:-}:${BASH_LINENO[${i}-1]-} ${FUNCNAME[${i}-1]-}()" # && continue
#	done 


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
#	(IFS=$'\n'; echo "${stack[*]}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller ${i}); do
#		echo >&2 [${i}] ${file}:${line} ${func}(): $(sed -n ${line}p ${file})
#		((i++))
#	done
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_info("called a function")
	dk_stacktrace()
endfunction()