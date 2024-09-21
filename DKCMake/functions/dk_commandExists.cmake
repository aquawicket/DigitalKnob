include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_commandExists()
#
#
function(dk_commandExists shell commandName rtn_var)
	dk_debugFunc("\${ARGV}")
	
	## Test for command in CMAKE
	if("${shell}" STREQUAL "CMAKE")
		if(COMMAND ${commandName})
			set(output_variable TRUE)
		else()
			set(output_variable FALSE)
		endif()
		set(${rtn_var} ${output_variable} PARENT_SCOPE)
		dk_printVar(output_variable)
		return()
		
	## Test for command in CMD
	elseif("${shell}" STREQUAL "CMD")
		dl_validate(CMD_EXE "dk_depend(cmd)")
		dk_validate(DKBATCH_FUNCTIONS_DIR "dk_validateBranch()")
		dk_command(${CMD_EXE} /c call "${DKBATCH_FUNCTIONS_DIR}/dk_commandExists.cmd" ${commandName} result & echo !result! OUTPUT_VARIABLE output_variable)
		set(${rtn_var} ${output_variable} PARENT_SCOPE)
		dk_printVar(output_variable)
		return()
		
	## Test for command in BASH	
	elseif("${shell}" STREQUAL "BASH")
		dl_validate(BASH_EXE "dk_depend(git)")
		dk_command(${BASH_EXE} -c "command -v cmake" OUTPUT_VARIABLE output_variable)
		set(${rtn_var} ${output_variable} PARENT_SCOPE)
		dk_printVar(output_variable)
		return()
		
	## Error
	else()
		dk_error("arg1:${shell} invalid. Choices are CMAKE, CMD and BASH")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
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
