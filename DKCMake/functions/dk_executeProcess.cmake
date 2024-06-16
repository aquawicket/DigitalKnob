include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_executeProcess(commands) NO_HALT NOECHO OUTPUT <output_variable>
#
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
	dk_debugFunc(${ARGV})
	
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
	dk_getOptionValue(COMMAND_ECHO 					${ARGV})
	dk_getOption(OUTPUT_STRIP_TRAILING_WHITESPACE 	${ARGV})
	dk_getOption(ERROR_STRIP_TRAILING_WHITESPACE 	${ARGV})
	dk_getOptionValue(ENCODING 						${ARGV})
	dk_getOption(ECHO_OUTPUT_VARIABLE				${ARGV})
	dk_getOption(ECHO_ERROR_VARIABLE				${ARGV})
	dk_getOptionValue(COMMAND_ERROR_IS_FATAL 		${ARGV})
	
	dk_getOption(NO_HALT 							${ARGV} REMOVE)
	dk_getOption(NOECHO 							${ARGV} REMOVE)

	#if(NOT ${NOECHO})
	#	dk_replaceAll("${ARGV}"  ";"  " "  print_commands)
	#	dk_info("\n${clr}${magenta} dk_executeProcess> ${print_commands}\n")
	#endif()
	
	if(NOT COMMAND)
		list(INSERT ARGV 0 COMMAND)  # add COMMAND if missing
	endif()
	
	# FIXME:  only in valid cmd shell
	find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		list(FIND ARGV "cmd;/c" index)
		if(${index} EQUAL -1)			# add cmd /c if missing
			list(INSERT ARGV 1 "cmd;/c")
		endif()
	endif()
	
	if(NOT WORKING_DIRECTORY)
		if(NOT CURRENT_DIR)
			dk_validate(DIGITALKNOB_DIR "dk_getDKPaths()")
			dk_set(CURRENT_DIR ${DIGITALKNOB_DIR})
		endif()
		set(WORKING_DIRECTORY ${CURRENT_DIR})
		list(APPEND ARGV WORKING_DIRECTORY ${WORKING_DIRECTORY}) # add WORKING_DIRECTORY if missing
	endif()
	
	if(NOT RESULT_VARIABLE)
		set(RESULT_VARIABLE result_variable)
		list(APPEND ARGV RESULT_VARIABLE ${RESULT_VARIABLE})
	endif()
	
#	if(NOT OUTPUT_VARIABLE)
#		set(OUTPUT_VARIABLE output_variable)
#		list(APPEND ARGV OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
#	endif()
	
	if(NOT ERROR_VARIABLE)
		set(ERROR_VARIABLE error_variable)
		list(APPEND ARGV ERROR_VARIABLE ${ERROR_VARIABLE})
	endif()
	
	list(APPEND ARGV COMMAND_ECHO STDOUT)
		
	#if(NOT ECHO_OUTPUT_VARIABLE)
	#	set(ECHO_OUTPUT_VARIABLE echo_output_variable)
	#	list(APPEND ARGV ECHO_OUTPUT_VARIABLE ${ECHO_OUTPUT_VARIABLE})
	#endif()
	
	#if(NOT ECHO_ERROR_VARIABLE)
	#	set(ECHO_ERROR_VARIABLE echo_error_variable)
	#	list(APPEND ARGV ECHO_ERROR_VARIABLE ${echo_error_variable})
	#endif()
	
	if(NOT OUTPUT_STRIP_TRAILING_WHITESPACE)
		list(APPEND ARGV OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
	
	#dk_replaceAll("${ARGV}"  ";"  " "  PRINT_ARGV)
#	dk_info("\n${clr}${magenta} dk_executeProcess(${ARGV})")
	execute_process(${ARGV})
	
	
	set(cmd1 ${ARGV})
	if(NOT ${result_variable} EQUAL 0)
		dk_sleep(2) # wait 2 seconds for the stdout to flush before printing error
		dk_echo(" ")
		dk_printVar(${cmd1})
		dk_printVar(${DIGITALKNOB_DIR})
		dk_printVar(result_variable)
		#dk_printVar(output_variable)
		dk_echo("${Blue-}output_variable =${red-} '${output_variable}'${clr-}")
		dk_printVar(error_variable)
		dk_error(" ")
#	else()
#		dk_verbose(" ")
#		dk_verbose(cmd1)
#		dk_verbose(WORKING_DIRECTORY)
#		dk_verbose(RESULT_VARIABLE)
#		dk_verbose(OUTPUT_VARIABLE)
#		dk_verbose(ERROR_VARIABLE)
#		dk_verbose(" ")
	endif()
	
	
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
	#if(${ECHO_OUTPUT_VARIABLE})
	#	set(${ECHO_OUTPUT_VARIABLE} ${${ECHO_OUTPUT_VARIABLE}} PARENT_SCOPE)
	#endif()
	#if(${ECHO_ERROR_VARIABLE})
	#	set(${ECHO_ERROR_VARIABLE} ${${ECHO_ERROR_VARIABLE}} PARENT_SCOPE)
	#endif()
	
endfunction()
dk_createOsMacros("dk_executeProcess")





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)
