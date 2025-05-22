#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_commandExists()
#
#
function(dk_commandExists shell commandName rtn_var)
	dk_debugFunc()
		
	## Test for command in BASH	
	if("${shell}" STREQUAL "BASH")
		dk_depend(bash)
		execute_process(COMMAND ${BASH_EXE} -c "command -v ${commandName}" OUTPUT_VARIABLE output)
		set(${rtn_var} ${output} PARENT_SCOPE)
		#dk_printVar(output)
		return()
	
	## Test for command in CMD
	elseif("${shell}" STREQUAL "CMD")
		dk_depend(cmd)
		dk_validate(ENV{DKBATCH_FUNCTIONS_DIR} "dk_DKBRANCH_DIR()")
		execute_process(COMMAND ${CMD_EXE} /c call "$ENV{DKBATCH_FUNCTIONS_DIR}/dk_commandExists.cmd" ${commandName} result & echo !result! OUTPUT_VARIABLE output)
		set(${rtn_var} ${output} PARENT_SCOPE)
		#dk_printVar(output)
		return()
		
	## Test for command in CMAKE
	elseif("${shell}" STREQUAL "CMAKE")
		if(COMMAND ${commandName})
			set(output TRUE)
		else()
			set(output FALSE)
		endif()
		set(${rtn_var} ${output} PARENT_SCOPE)
		#dk_printVar(output)
		return()
		
	## Error
	else()
		dk_error("arg1:${shell} invalid. Choices are BASH, CMD and CMAKE")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_commandExists(CMAKE "echo" cmake_echo)
	if(cmake_echo)
		dk_info("CMAKE command: echo exists")
	else()
		dk_info("CMAKE command: echo does not exist")
	endif()
	
	
	dk_commandExists(CMD "echo" cmd_echo)
	if(cmd_echo)
		dk_info("CMD command: echo exists")
	else()
		dk_info("CMD command: echo does not exist")
	endif()
	
	
	dk_commandExists(BASH "echo" bash_echo)
	if(bash_echo)
		dk_info("BASH command: echo exists")
	else()
		dk_info("BASH command: echo does not exist")
	endif()
endfunction()
