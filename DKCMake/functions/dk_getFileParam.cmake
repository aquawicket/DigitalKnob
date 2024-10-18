#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_getFileParam(file, var_name) value
#
# todo: add optional 3rd parameter for output value
function(dk_getFileParam)
    dk_debugFunc(2)
    
	#message("ARGV0 = ${ARGV0}")
	file(READ "${ARGV0}" content)
	#message("content = ${content}")
	foreach(line IN LISTS content)
	#message("line = ${line}")
	string(FIND "${line}" "=" pos)
	#message("pos = ${pos}")
    if(pos GREATER -1)
        string(SUBSTRING "${line}" 0 ${pos} A)
		math(EXPR pos "${pos}+1" OUTPUT_FORMAT DECIMAL) 
        string(SUBSTRING "${line}" ${pos} -1 B)
			#message("A:${A} = B:${B}")
			if("${A}" STREQUAL "${ARGV1}")
				unset("${ARGV1}")
				#message("${ARGV2} = ${B}")
				set(${A} "${B}" PARENT_SCOPE)
			endif()
		endif()
	endforeach()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
  
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
    dk_getFileParam(${DKIMPORTS_DIR}/git/version.txt VERSION)
	dk_printVar(VERSION)
endfunction()
