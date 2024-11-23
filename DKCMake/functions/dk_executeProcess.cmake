#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_executeProcess(commands) NO_HALT NOECHO OUTPUT <output_variable>
#
#	@commands	- TODO
#	@NO_HALT	- don't halt cmake if an error occurs
#
#	@options	- Takes in and passes the same options as execute_process
#	execute_process(COMMAND <cmd1> [<arguments>]
#					[COMMAND <cmd2> [<arguments>]]...
#					[WORKING_DIRECTORY <directory>]
#					[TIMEOUT <seconds>]
#					[RESULT_VARIABLE <variable>]
#					[RESULTS_VARIABLE <variable>]
#					[OUTPUT_VARIABLE <variable>]
#					[ERROR_VARIABLE <variable>]
#					[INPUT_FILE <file>]
#					[OUTPUT_FILE <file>]
#					[ERROR_FILE <file>]
#					[OUTPUT_QUIET]
#					[ERROR_QUIET]
#					[COMMAND_ECHO <where>]
#					[OUTPUT_STRIP_TRAILING_WHITESPACE]
#					[ERROR_STRIP_TRAILING_WHITESPACE]
#					[ENCODING <name>]
#					[ECHO_OUTPUT_VARIABLE]
#					[ECHO_ERROR_VARIABLE]
#					[COMMAND_ERROR_IS_FATAL <ANY|LAST>])
#
function(dk_executeProcess)
	dk_debugFunc()
	
	set(cmd1 										${ARGV})
	dk_getOptionValues(COMMAND 						${ARGV})
	list(REMOVE_ITEM cmd1 COMMAND)
	dk_getOptionValue(WORKING_DIRECTORY 			${ARGV})
	list(REMOVE_ITEM cmd1 WORKING_DIRECTORY)
	list(REMOVE_ITEM cmd1 ${WORKING_DIRECTORY})
	dk_getOptionValue(TIMEOUT 						${ARGV})
	list(REMOVE_ITEM cmd1 TIMEOUT)
	list(REMOVE_ITEM cmd1 ${TIMEOUT})
	dk_getOptionValue(RESULT_VARIABLE 				${ARGV})
	list(REMOVE_ITEM cmd1 RESULT_VARIABLE)
	list(REMOVE_ITEM cmd1 ${RESULT_VARIABLE})
	dk_getOptionValue(RESULTS_VARIABLE 				${ARGV})
	list(REMOVE_ITEM cmd1 RESULTS_VARIABLE)
	list(REMOVE_ITEM cmd1 ${RESULTS_VARIABLE})
	dk_getOptionValue(OUTPUT_VARIABLE 				${ARGV})
	list(REMOVE_ITEM cmd1 OUTPUT_VARIABLE)
	list(REMOVE_ITEM cmd1 ${OUTPUT_VARIABLE})
	dk_getOptionValue(ERROR_VARIABLE 				${ARGV})
	list(REMOVE_ITEM cmd1 ERROR_VARIABLE)
	list(REMOVE_ITEM cmd1 ${ERROR_VARIABLE})
	dk_getOptionValue(INPUT_FILE 					${ARGV})
	list(REMOVE_ITEM cmd1 INPUT_FILE)
	list(REMOVE_ITEM cmd1 ${INPUT_FILE})
	dk_getOptionValue(OUTPUT_FILE 					${ARGV})
	list(REMOVE_ITEM cmd1 OUTPUT_FILE)
	list(REMOVE_ITEM cmd1 ${OUTPUT_FILE})
	dk_getOptionValue(ERROR_FILE 					${ARGV})
	list(REMOVE_ITEM cmd1 ERROR_FILE)
	list(REMOVE_ITEM cmd1 ${ERROR_FILE})
	dk_getOption(OUTPUT_QUIET						${ARGV})
	list(REMOVE_ITEM cmd1 OUTPUT_QUIET)
	dk_getOption(ERROR_QUIET						${ARGV})
	list(REMOVE_ITEM cmd1 ERROR_QUIET)
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
		dk_getOptionValue(COMMAND_ECHO 				${ARGV})
	endif()
	list(REMOVE_ITEM cmd1 COMMAND_ECHO)
	list(REMOVE_ITEM cmd1 ${COMMAND_ECHO})
	dk_getOption(OUTPUT_STRIP_TRAILING_WHITESPACE 	${ARGV})
	list(REMOVE_ITEM cmd1 OUTPUT_STRIP_TRAILING_WHITESPACE)
	dk_getOption(ERROR_STRIP_TRAILING_WHITESPACE 	${ARGV})
	list(REMOVE_ITEM cmd1 ERROR_STRIP_TRAILING_WHITESPACE)
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.8")
		dk_getOptionValue(ENCODING 					${ARGV})
	endif()
	list(REMOVE_ITEM cmd1 ENCODING)
	list(REMOVE_ITEM cmd1 ${ENCODING})
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
		dk_getOption(ECHO_OUTPUT_VARIABLE			${ARGV})
		dk_getOption(ECHO_ERROR_VARIABLE			${ARGV})
	endif()
	list(REMOVE_ITEM cmd1 ECHO_OUTPUT_VARIABLE)
	list(REMOVE_ITEM cmd1 ECHO_ERROR_VARIABLE)
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.19")
		dk_getOptionValue(COMMAND_ERROR_IS_FATAL 	${ARGV})
	endif()
	list(REMOVE_ITEM cmd1 COMMAND_ERROR_IS_FATAL)
	list(REMOVE_ITEM cmd1 ${COMMAND_ERROR_IS_FATAL})
	dk_getOption(NO_HALT 							${ARGV} REMOVE)
	list(REMOVE_ITEM cmd1 NO_HALT)
	dk_getOption(NOECHO 							${ARGV} REMOVE)
	list(REMOVE_ITEM cmd1 NOECHO)

	if(NOT COMMAND)
		list(INSERT ARGV 0 COMMAND)  # insert COMMAND if missing
	endif()
	
	if(WIN32)
		dk_validate(CMD_EXE "dk_depend(cmd)")
		if(CMD_EXE)
			if(NOT ARGV MATCHES "cmd;/c")		
				list(INSERT ARGV 1 "cmd;/c") # add cmd /c if missing
			endif()
		endif()
	endif()
	
	### WORKING_DIRECTORY ###
	# defaults to ${PWD} set by dk_cd(directory)
	# since CMAKE doesn't use a default PWD or CD current directory, we make our own by keeping
	# the PWD variable updated with the desired path. Any calls to execute_process
	# will use value of that variable unless WORKING_DIRECTORY is specified in the function call.
	if(NOT WORKING_DIRECTORY)
		if(NOT PWD)
			dk_cd(${DIGITALKNOB_DIR})
		endif()
		list(APPEND ARGV WORKING_DIRECTORY "${PWD}") # add WORKING_DIRECTORY if missing
	endif()
	
	### TIMEOUT ###
#	if(NOT TIMEOUT)
#		set(TIMEOUT 5)
#		list(APPEND ARGV TIMEOUT ${TIMEOUT})
#	endif()
	
	### RESULT_VARIABLE ###
	if(NOT RESULT_VARIABLE)
		set(RESULT_VARIABLE result_variable)
		list(APPEND ARGV RESULT_VARIABLE ${RESULT_VARIABLE})
	endif()
	
	### RESULTS_VARIABLE ###
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.10")
		if(NOT RESULTS_VARIABLE)
			set(RESULTS_VARIABLE results_variable)
			list(APPEND ARGV RESULTS_VARIABLE ${RESULTS_VARIABLE})
		endif()
	endif()
	
	### OUTPUT_VARIABLE ###
	if(NOT OUTPUT_VARIABLE)
		set(OUTPUT_VARIABLE output_variable)
		list(APPEND ARGV OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	### ERROR_VARIABLE ###
	if(NOT ERROR_VARIABLE)
		set(ERROR_VARIABLE error_variable)
		list(APPEND ARGV ERROR_VARIABLE ${ERROR_VARIABLE})
	endif()
	
#	### INPUT_FILE ###
#	if(NOT INPUT_FILE)
#		set(INPUT_FILE input_file,txt)
#		list(APPEND ARGV INPUT_FILE ${INPUT_FILE})
#	endif()
	
#	### OUTPUT_FILE ###
#	if(NOT OUTPUT_FILE)
#		set(OUTPUT_FILE output_file.txt)
#		list(APPEND ARGV OUTPUT_FILE ${OUTPUT_FILE})
#	endif()
	
	### ERROR_FILE ###
#	if(NOT ERROR_FILE)
#		set(ERROR_FILE error_file.txt)
#		list(APPEND ARGV ERROR_FILE ${ERROR_FILE})
#	endif()
	
	### OUTPUT_QUIET ###
#	if(NOT OUTPUT_QUIET)
#		list(APPEND ARGV OUTPUT_QUIET)
#	endif()
	
	### ERROR_QUIET ###
#	if(NOT ERROR_QUIET)
#		list(APPEND ARGV ERROR_QUIET)
#	endif()
	
#	### COMMAND_ECHO ###
#	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
#		if(NOT COMMAND_ECHO)
#			set(COMMAND_ECHO STDOUT)
#			list(APPEND ARGV COMMAND_ECHO ${COMMAND_ECHO})
#		endif()
#	endif()
	
	### OUTPUT_STRIP_TRAILING_WHITESPACE ###
	if(NOT OUTPUT_STRIP_TRAILING_WHITESPACE)
		list(APPEND ARGV OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
	
	### ERROR_STRIP_TRAILING_WHITESPACE ###
	if(NOT ERROR_STRIP_TRAILING_WHITESPACE)
		list(APPEND ARGV ERROR_STRIP_TRAILING_WHITESPACE)
	endif()
	
	### ENCODING ###
#	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.8")
#		if(NOT ENCODING)
#			list(APPEND ARGV ENCODING UTF-8)
#		endif()
#	endif()
	
	### ECHO_OUTPUT_VARIABLE ###
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
		if(NOT ECHO_OUTPUT_VARIABLE)
			list(APPEND ARGV ECHO_OUTPUT_VARIABLE)
		endif()
	endif()
	
	### ECHO_ERROR_VARIABLE ###
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
		if(NOT ECHO_ERROR_VARIABLE)
			list(APPEND ARGV ECHO_ERROR_VARIABLE)
		endif()
	endif()
	
	### COMMAND_ERROR_IS_FATAL ###
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.19")
		if(NOT COMMAND_ERROR_IS_FATAL)
			list(APPEND ARGV COMMAND_ERROR_IS_FATAL ANY)
		endif()
	endif()
	
	###################################################
	
	dk_reparseCmakeCommand(ARGV) # support longer command lines
	
#	if(NOT NOECHO)
#		dk_replaceAll("${ARGV}"  ";"  " "  cmd1)	
#		dk_echo("${lblue}command> ${lcyan}${cmd1}${clr}")
#	endif()

	dk_echo("${lblue}execute_process> ${lcyan}${ARGV}${clr}")
	execute_process(${ARGV})
	
#	if(NOT ${result_variable} EQUAL 0)
		dk_sleep(1) # wait 1 second1 for the stdout to flush before printing
		if(${RESULT_VARIABLE})
			dk_info("${${RESULT_VARIABLE}}")
		endif()
		if(${RESULTS_VARIABLE})
			dk_info("${${RESULTS_VARIABLE}}")
		endif()
#		if(${OUTPUT_VARIABLE})
#			dk_info("${${OUTPUT_VARIABLE}}")
#		endif()
		if(${ERROR_VARIABLE})
			dk_info("${${ERROR_VARIABLE}}")
		endif()
		if(${${RESULT_VARIABLE}})
			dk_fatal("${${RESULT_VARIABLE}}" ${NO_HALT})
		endif()
#	else()
	
	if(${RESULT_VARIABLE})
		set(${RESULT_VARIABLE}  ${${RESULT_VARIABLE}}  PARENT_SCOPE)
	endif()
	if(${RESULTS_VARIABLE})
		set(${RESULTS_VARIABLE} ${${RESULTS_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${OUTPUT_VARIABLE})
		set(${OUTPUT_VARIABLE}  ${${OUTPUT_VARIABLE}}  PARENT_SCOPE)
	endif()
	if(${ERROR_VARIABLE})
		set(${ERROR_VARIABLE}   ${${ERROR_VARIABLE}}   PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_executeProcess(echo "Hello World" ERROR_VARIABLE test_error OUTPUT_VARIABLE test_output)
endfunction()
