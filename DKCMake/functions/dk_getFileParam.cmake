#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
=======
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
>>>>>>> Development
#include_guard()

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
  
<<<<<<< HEAD
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
    dk_getFileParam(${DKIMPORTS_DIR}/git/git.txt VERSION)
	dk_printVar(VERSION)
=======
	dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_getFileParam("$ENV{DKIMPORTS_DIR}/git/dkconfig.txt" GIT_DL_WIN_X86_64)
	dk_printVar(GIT_DL_WIN_X86_64)
>>>>>>> Development
endfunction()
