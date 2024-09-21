include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_commandExists()
#
#
function(dk_commandExists shell commandName rtn_var)
	#dk_debugFunc("\${ARGV}")
	
	## Test for command in cmake
	if("${shell}" STREQUAL "BASH")
		if(COMMAND ${commandName})
			set(output_variable TRUE)
		else()
			set(output_variable FALSE)
		endif()
		set(${rtn_var} ${output_variable} PARENT_SCOPE)
		dk_printVar(output_variable)
		return()
	endif()
	
	## Test for command in cmd
	if("${shell}" STREQUAL "CMD")
		dk_validate(DKBRANCH_DIR "dk_validateBranch()")
		dk_command(cmd /c call "${DKBRANCH_DIR}/DKBatch/functions/dk_commandExists.cmd" ${commandName} result & echo !result! OUTPUT_VARIABLE output_variable)
		set(${rtn_var} ${output_variable} PARENT_SCOPE)
		dk_printVar(output_variable)
		return()
	endif()

	## Test for command in bash
	if("${shell}" STREQUAL "BASH")
		dk_command(bash -c "command -v cmake" OUTPUT_VARIABLE output_variable)
		set(${rtn_var} ${output_variable} PARENT_SCOPE)
		dk_printVar(output_variable)
		return()
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	#dk_debugFunc("\${ARGV}")
	
	dk_commandExists(CMD "echo" echo_exists)
	if(echo_exists)
		dk_info("CMD command: echo exists")
	else()
		dk_info("CMD command: echo does not exist")
	endif()
endfunction()
