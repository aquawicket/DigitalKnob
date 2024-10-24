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
	
	
	dk_getOptionValues(COMMAND 						${ARGV})
	dk_getOptionValue(WORKING_DIRECTORY 			${ARGV})
	dk_getOptionValue(TIMEOUT 						${ARGV})
	dk_getOptionValue(RESULT_VARIABLE 				${ARGV})
	dk_getOptionValue(RESULTS_VARIABLE 				${ARGV})
	dk_getOptionValue(OUTPUT_VARIABLE 				${ARGV})
	dk_getOptionValue(ERROR_VARIABLE 				${ARGV})
	dk_getOptionValue(INPUT_FILE 					${ARGV})
	dk_getOptionValue(OUTPUT_FILE 					${ARGV})
	dk_getOptionValue(ERROR_FILE 					${ARGV})
	dk_getOption(OUTPUT_QUIET						${ARGV})
	dk_getOption(ERROR_QUIET						${ARGV})
	if(CMAKE_VERSION VERSION_GREATER "3.15")
		dk_getOptionValue(COMMAND_ECHO 				${ARGV})
	endif()
	dk_getOption(OUTPUT_STRIP_TRAILING_WHITESPACE 	${ARGV})
	dk_getOption(ERROR_STRIP_TRAILING_WHITESPACE 	${ARGV})
	dk_getOptionValue(ENCODING 						${ARGV})
	if(CMAKE_VERSION VERSION_GREATER "3.18")
		dk_getOption(ECHO_OUTPUT_VARIABLE			${ARGV})
		dk_getOption(ECHO_ERROR_VARIABLE			${ARGV})
	endif()
	dk_getOptionValue(COMMAND_ERROR_IS_FATAL 		${ARGV})
	
	dk_getOption(NO_HALT 							${ARGV} REMOVE)
	dk_getOption(NOECHO 							${ARGV} REMOVE)

	#if(NOT ${NOECHO})
	#	dk_replaceAll("${ARGV}"  ";"  " "  print_commands)
	#	dk_info("\n${clr}${magenta} dk_executeProcess> ${print_commands}\n")
	#endif()
	
	if(NOT COMMAND)
		list(INSERT ARGV 0 COMMAND)  # insert COMMAND if missing
	endif()
	
	# FIXME:  only in valid cmd shell
	if(WIN32)
		dk_depend(cmd)
		if(CMD_EXE)
			list(FIND ARGV "cmd;/c" index)
			if(${index} EQUAL -1)			# add cmd /c if missing
				list(INSERT ARGV 1 "cmd;/c")
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
		list(APPEND ARGV WORKING_DIRECTORY ${PWD}) # add WORKING_DIRECTORY if missing
	endif()
	
	### TIMEOUT ###
	
	### RESULT_VARIABLE ###
	if(NOT RESULT_VARIABLE)
		set(RESULT_VARIABLE result_variable)
		list(APPEND ARGV RESULT_VARIABLE ${RESULT_VARIABLE})
	endif()
	
	### RESULTS_VARIABLE ###
	
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
	
	### INPUT_FILE ###
	
	### OUTPUT_FILE ###
	
	### ERROR_FILE ###
	
	### OUTPUT_QUIET ###
	
	### ERROR_QUIET ###
	
	### COMMAND_ECHO ###
	if(CMAKE_VERSION VERSION_GREATER "3.15")
		if(NOT COMMAND_ECHO)
			set(COMMAND_ECHO STDOUT)
			list(APPEND ARGV COMMAND_ECHO ${COMMAND_ECHO})
		endif()
	endif()
	
	### OUTPUT_STRIP_TRAILING_WHITESPACE ###
	if(NOT OUTPUT_STRIP_TRAILING_WHITESPACE)
		list(APPEND ARGV OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
	
	### ERROR_STRIP_TRAILING_WHITESPACE ###
	
	### ENCODING ###
	
	### ECHO_OUTPUT_VARIABLE ###
	
	### ECHO_ERROR_VARIABLE ###
	
	if(CMAKE_VERSION VERSION_GREATER "3.18")
		if(NOT ECHO_OUTPUT_VARIABLE)
			list(APPEND ARGV ECHO_OUTPUT_VARIABLE)
		endif()
		if(NOT ECHO_ERROR_VARIABLE)
			list(APPEND ARGV ECHO_ERROR_VARIABLE)
		endif()
	endif()
	
	
	
#	####### SUPPORT LONGER CMAKE COMMAND LINES ######
	set(cmd1 ${ARGV})
	dk_reparseCmakeCommand(cmd1)
	
#	dk_replaceAll("${ARGV}"  ";"  " "  PRINT_ARGV)
#	dk_info("\n${clr}${magenta} dk_executeProcess(${ARGV})")
		execute_process(${cmd1})
#	endif()
	
	
#	if(NOT ${result_variable} EQUAL 0)
		dk_sleep(2) # wait 2 seconds for the stdout to flush before printing
		dk_echo(" ")
		dk_echo("${cyan}cmd1 =${white} '${cmd1}'${clr}")
		if(RESULT_VARIABLE)
			dk_printVar(RESULT_VARIABLE)
		endif()
		if(RESULTS_VARIABLE)
			dk_printVar(RESULTS_VARIABLE)
		endif()
		if(OUTPUT_VARIABLE)
			dk_printVar(OUTPUT_VARIABLE)
		endif()
		if(ERROR_VARIABLE)
			dk_printVar(ERROR_VARIABLE)
		endif()
		#dk_echo("${cyan}result_variable =${blue} '${result_variable}'${clr}")
		#dk_echo("${cyan}output_variable =${white} '${output_variable}'${clr}")
		#dk_echo("${cyan}error_variable =${red} '${error_variable}'${clr}")
	if(NOT ${${RESULT_VARIABLE}} EQUAL 0)
		dk_fatal(" " ${NO_HALT})
	endif()
#	else()
#		dk_verbose(" ")
#		dk_verbose(cmd1)
#		dk_verbose(PWD)
#		dk_verbose(RESULT_VARIABLE)
#		dk_verbose(OUTPUT_VARIABLE)
#		dk_verbose(ERROR_VARIABLE)
#		dk_verbose(" ")
#	endif()
	
	
	if(${RESULT_VARIABLE})
		set(${RESULT_VARIABLE} ${${RESULT_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${RESULTS_VARIABLE})
		set(${RESULTS_VARIABLE} ${${RESULTS_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${OUTPUT_VARIABLE})
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
	if(${ERROR_VARIABLE})
		set(${ERROR_VARIABLE} ${${ERROR_VARIABLE}} PARENT_SCOPE)
	endif()
	
endfunction()
dk_createOsMacros("dk_executeProcess")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_executeProcess(cmd /c "echo Hello World" ERROR_VARIABLE test_error OUTPUT_VARIABLE test_output)
endfunction()
