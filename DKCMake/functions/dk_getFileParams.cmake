#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#include_guard()


################## dk_getFileParams settings ###################################
if(NOT DEFINED dk_getFileParams_PRINT_VARIABLES)
	set(dk_getFileParams_PRINT_VARIABLES 1)
endif()
################################################################################
# dk_getFileParams(file)
#
function(dk_getFileParams)
    dk_debugFunc(1)
    
	file(READ "${ARGV0}" file_content)
	string(REGEX REPLACE "\n" ";" file_content_list "${file_content}")
	
	if("${dk_getFileParams_PRINT_VARIABLES}" EQUAL 1)
		message("\n### ${ARGV0} Parameters ###")
	endif()
				
	# iterate through each line
	foreach(line IN LISTS file_content_list)
		
		# remove comments - everything after # 
		string(FIND "${line}" "#" comment)
		if(comment GREATER -1)
			string(SUBSTRING "${line}" 0 ${comment} line)	
		endif()
		
		string(FIND "${line}" "=" pos)
		if(pos GREATER -1)
			string(SUBSTRING "${line}" 0 ${pos} Var)
			math(EXPR pos "${pos}+1" OUTPUT_FORMAT DECIMAL) 
			string(SUBSTRING "${line}" ${pos} -1 Value)
				set(${Var} "${Value}" PARENT_SCOPE)
				if("${dk_getFileParams_PRINT_VARIABLES}" EQUAL 1)
					message("${Var} = ${Value}")
				endif()
		endif()
	endforeach()
	
	if("${dk_getFileParams_PRINT_VARIABLES}" EQUAL 1)
		message(" ")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
  
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
    dk_getFileParams("$ENV{DKBRANCH_DIR}/dkconfig.txt")
	dk_printVar(dk_getAllFileParams_ENABLE)
endfunction()
