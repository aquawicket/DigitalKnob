include_guard()

###############################################################################
# dk_executeProcess(commands) NOASSERT NOECHO OUTPUT <output_variable>
#
#
#	@commands	- TODO
#	@NOASSERT	- don't halt cmake if an error occurs
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
	DKDEBUGFUNC(${ARGV})
	dk_get_option_values(COMMAND 					${ARGV})
	dk_get_option_value(WORKING_DIRECTORY 			${ARGV})
	dk_get_option_value(TIMEOUT 					${ARGV})
	dk_get_option_value(RESULT_VARIABLE 			${ARGV})
	dk_get_option_value(RESULTS_VARIABLE 			${ARGV})
	dk_get_option_value(OUTPUT_VARIABLE 			${ARGV})
	dk_get_option_value(ERROR_VARIABLE 				${ARGV})
	dk_get_option_value(INPUT_FILE 					${ARGV})
	dk_get_option_value(OUTPUT_FILE 				${ARGV})
	dk_get_option_value(ERROR_FILE 					${ARGV})
	dk_get_option(OUTPUT_QUIET						${ARGV})
	dk_get_option(ERROR_QUIET						${ARGV})
	dk_get_option_value(COMMAND_ECHO 				${ARGV})
	dk_get_option(OUTPUT_STRIP_TRAILING_WHITESPACE 	${ARGV})
	dk_get_option(ERROR_STRIP_TRAILING_WHITESPACE 	${ARGV})
	dk_get_option_value(ENCODING 					${ARGV})
	dk_get_option(ECHO_OUTPUT_VARIABLE				${ARGV})
	dk_get_option(ECHO_ERROR_VARIABLE				${ARGV})
	dk_get_option_value(COMMAND_ERROR_IS_FATAL 		${ARGV})
	
	dk_get_option(NOASSERT 							${ARGV} REMOVE)
	dk_get_option(NOECHO 							${ARGV} REMOVE)
	dk_debug("dk_executeProcess(${ARGV})")
	#if(NOT ${NOECHO})
	#	string(REPLACE ";" " " print_commands "${ARGV}")
	#	dk_info("\n${CLR}${magenta} dk_executeProcess> ${print_commands}\n")
	#endif()
	
	if(NOT COMMAND)
		list(INSERT ARGV 0 COMMAND)  # add COMMAND if missing
	endif()
	
	# FIXME:  only in valid cmd shell
	if(WIN_HOST)
		list(FIND ARGV "cmd;/c" index)
		if(${index} EQUAL -1)			# add cmd /c if missing
			list(INSERT ARGV 1 "cmd;/c")
		endif()
	endif()
	
	if(NOT WORKING_DIRECTORY)
		set(WORKING_DIRECTORY ${CURRENT_DIR})
		list(APPEND ARGV WORKING_DIRECTORY ${WORKING_DIRECTORY}) # add WORKING_DIRECTORY if missing
	endif()
	
	if(NOT RESULT_VARIABLE)
		set(RESULT_VARIABLE result_variable)
		list(APPEND ARGV RESULT_VARIABLE ${RESULT_VARIABLE})
	endif()
	
	if(NOT OUTPUT_VARIABLE)
		set(OUTPUT_VARIABLE output_variable)
		list(APPEND ARGV OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ERROR_VARIABLE)
		set(ERROR_VARIABLE error_variable)
		list(APPEND ARGV ERROR_VARIABLE ${ERROR_VARIABLE})
	endif()
	
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
	
	#string(REPLACE ";" " " PRINT_ARGV "${ARGV}")
	dk_info("\n${CLR}${magenta} execute_process(${ARGV})")
	execute_process(${ARGV})
	
	
	set(cmd1 ${ARGV})
	if(NOT ${result_variable} EQUAL 0)
		dk_sleep(2) # wait 2 seconds for the stdout to flush before printing error
		dk_error(" "				NOASSERT)
		dk_error(cmd1				PRINTVAR NOASSERT)
		dk_error(WORKING_DIRECTORY	PRINTVAR NOASSERT)
		dk_error(RESULT_VARIABLE    PRINTVAR NOASSERT)
		dk_error(OUTPUT_VARIABLE    PRINTVAR NOASSERT)
		dk_error(ERROR_VARIABLE     PRINTVAR NOASSERT)
		dk_error(" "				${NOASSERT})
	else()
		dk_verbose(" ")
		dk_verbose(cmd1		    		PRINTVAR)
		dk_verbose(WORKING_DIRECTORY	PRINTVAR)
		dk_verbose(RESULT_VARIABLE    	PRINTVAR)
		dk_verbose(OUTPUT_VARIABLE    	PRINTVAR)
		dk_verbose(ERROR_VARIABLE     	PRINTVAR)
		dk_verbose(" ")
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
