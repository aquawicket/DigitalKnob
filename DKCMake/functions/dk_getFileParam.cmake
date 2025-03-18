#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_getFileParam(file, var_name) value
#
# todo: add optional 3rd parameter for output value
function(dk_getFileParam)
    dk_debugFunc(2)
    
	file(READ "${ARGV0}" file_content)
	string(REGEX REPLACE "\n" ";" file_content_list "${file_content}")
	foreach(line IN LISTS file_content_list)
	string(FIND "${line}" "=" pos)
    if(pos GREATER -1)
        string(SUBSTRING "${line}" 0 ${pos} A)
		math(EXPR pos "${pos}+1" OUTPUT_FORMAT DECIMAL) 
        string(SUBSTRING "${line}" ${pos} -1 B)
			if("${A}" STREQUAL "${ARGV1}")
				unset("${ARGV1}")
				set(${A} "${B}" PARENT_SCOPE)
				return()
			endif()
		endif()
	endforeach()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
  
	dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_getFileParam($ENV{DKIMPORTS_DIR}/git/git.txt VERSION)
	dk_printVar(VERSION)
endfunction()
