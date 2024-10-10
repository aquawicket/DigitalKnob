#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
	dk_debugFunc("\${ARGV}")
	
	
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
		dk_getOptionValue(COMMAND_ECHO 					${ARGV})
	endif()
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
	dk_depend(cmd)
	#find_program(CMD_EXE cmd.exe)
	if(WIN32)
		if(CMD_EXE)
			list(FIND ARGV "cmd;/c" index)
			if(${index} EQUAL -1)			# add cmd /c if missing
				list(INSERT ARGV 1 "cmd;/c")
			endif()
		endif()
	endif()
	
	# WORKING_DIRECTORY defaults to ${PWD} set by dk_cd(directory)
	# since CMAKE doesn't use a default PWD or CD current directory, we make our own by keeping
	# the PWD variable updated with the desired path. Any calls to execute_process
	# will use value of that variable unless WORKING_DIRECTORY is specified in the function call.
	if(NOT WORKING_DIRECTORY)
		if(NOT PWD)
			dk_cd(${DIGITALKNOB_DIR})
		endif()
		list(APPEND ARGV WORKING_DIRECTORY ${PWD}) # add WORKING_DIRECTORY if missing
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
	
	if(CMAKE_VERSION VERSION_GREATER "3.15")
		list(APPEND ARGV COMMAND_ECHO STDOUT)
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
	
	#dk_replaceAll("${ARGV}"  ";"  " "  PRINT_ARGV)
#	dk_info("\n${clr}${magenta} dk_executeProcess(${ARGV})")
	execute_process(${ARGV})
	
	
	set(cmd1 ${ARGV})
	if(NOT ${result_variable} EQUAL 0)
		dk_sleep(2) # wait 2 seconds for the stdout to flush before printing error
		dk_echo(" ")
		dk_echo("${cyan-}cmd1 =${white-} '${cmd1}'${clr-}")
		dk_echo("${cyan-}result_variable =${blue-} '${result_variable}'${clr-}")
		dk_echo("${cyan-}output_variable =${white-} '${output_variable}'${clr-}")
		dk_echo("${cyan-}error_variable =${red-} '${error_variable}'${clr-}")
		dk_fatal(" " ${NO_HALT})
#	else()
#		dk_verbose(" ")
#		dk_verbose(cmd1)
#		dk_verbose(PWD)
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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	set(DKDOWNLOAD_DIR "C:/Users/Administrator/DigitalKnob/download")
	set(MSYS2_DL_FILE "msys2-x86_64-20231026.exe")
	set(MSYS2 "C:/Users/Administrator/DigitalKnob/download/msys2-x86_64-20231026")

	
#	set(MSYS2_DL_PATH "${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}")
	dk_getNativePath("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" MSYS2_DL_PATH)
	string(REPLACE "\\" "//" MSYS2_DL_PATH "${MSYS2_DL_PATH}")
#	string(REPLACE " " "\\\\ " MSYS2_DL_PATH "${MSYS2_DL_PATH}")
	
	dk_getNativePath("${MSYS2_DIR}" MSYS2)
	dk_cd("${MSYS2_DIR}")
	string(REPLACE "\\" "//" MSYS2 "${MSYS2_DIR}")
#	string(REPLACE " " "\\ " MSYS2 "${MSYS2_DIR}")
#	dk_makeDirectory("${MSYS2_DIR}")
	
#	list(APPEND args cmd)
#	list(APPEND args /c)
#	list(APPEND args ${MSYS2_DL_PATH})
	list(APPEND args install)
	list(APPEND args --confirm-command)
	list(APPEND args --root)
#	list(APPEND args "${MSYS2_DIR}")
#	set(args "${MSYS2_DL_PATH};install;--confirm-command;--root;${MSYS2_DIR}")
#	set(args "${MSYS2_DL_PATH}";install;--confirm-command;--root;"${MSYS2_DIR}")
#	set(args "${MSYS2_DL_PATH}")
	#set(args notepad.exe)
	execute_process(COMMAND ${MSYS2_DL_PATH} "${args}" "${MSYS2_DIR}" WORKING_DIRECTORY "${MSYS2_DIR}")
#	dk_executeProcess(${MSYS2_DL_PATH} "${args}" "${MSYS2_DIR}")
endfunction()
