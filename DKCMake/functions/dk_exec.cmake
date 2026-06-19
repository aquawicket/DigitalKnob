#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################



# dk_exec(commands) NO_HALT NOECHO OUTPUT <output_variable>
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
function(dk_exec)
	dk_debugFunc()
	
	###### dk_exec() SETTINGS ######################################################################
#	       OPTION                   VALUE		 OPTONS / VARIABLES						DEFAULT
#	dk_set(dk_exec_ECHO_OUTPUT		1)													 
	dk_set(dk_exec_ECHO_ERROR		1)
#	dk_set(dk_exec_ECHO				STDOUT) 	# STDERR, STDOUT, NONE
#	dk_set(dk_exec_ERROR_IS_FATAL	NONE)		# ANY, LAST, NONE
	#dk_set(dk_exec_ENCODING		NONE)		# NONE, AUTO, ANSI, OEM, UTF-8, UTF8

#	dk_set(dk_exec_PRINT_CALL		1) 			# dk_exec_call
#	dk_set(dk_exec_PRINT_COMMAND	1) 			# dk_exec_command
#	dk_set(dk_exec_PRINT_EXITCODES	1)			# dk_exec_exitcodes
#	dk_set(dk_exec_PRINT_EXITCODE 	1)			# dk_exec_exitcode
#	dk_set(dk_exec_PRINT_STDERR 	1)			# dk_exec_stderr[]
#	dk_set(dk_exec_PRINT_STDOUT		1)			# dk_exec_stdout[]
#	dk_set(dk_exec_PRINT_OUTPUT 	1)			# dk_exec
	#########################################################################

	set(dk_exec_call 	${ARGV})
	set(dk_exec_command	${ARGV})
	
#	dk_getParameter(BASH_ENV REMOVE)
#	if(BASH_ENV)
#		dk_notice("#########################################################################")
#		dk_notice("dk_bashEnv SHOULD NOT BE USED!  take a look at how /_DKIMPORTS/openssl/DKINSTALL.cmake runs configure for Windows_X86_64_Clang from cmd.")
#		dk_notice("#########################################################################")
#		dk_pause()
#		return()
#	endif()
	
	dk_getParameterValues(COMMAND)
	dk_getParameterValue(WORKING_DIRECTORY)
	dk_getParameterValue(TIMEOUT)
	dk_getParameterValue(RESULT_VARIABLE)
	dk_getParameterValue(RESULTS_VARIABLE)
	dk_getParameterValue(OUTPUT_VARIABLE)
	dk_getParameterValue(ERROR_VARIABLE)
	dk_getParameterValue(INPUT_FILE)
	dk_getParameterValue(OUTPUT_FILE)
	dk_getParameterValue(ERROR_FILE)
	dk_getParameter(OUTPUT_QUIET)
	dk_getParameter(ERROR_QUIET)
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
		dk_getParameterValue(COMMAND_ECHO)
	endif()
	dk_getParameter(OUTPUT_STRIP_TRAILING_WHITESPACE)
	dk_getParameter(ERROR_STRIP_TRAILING_WHITESPACE)
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.8")
		dk_getParameterValue(ENCODING)
	endif()
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
		dk_getParameter(ECHO_OUTPUT_VARIABLE)
		dk_getParameter(ECHO_ERROR_VARIABLE)
	endif()
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.19")
		dk_getParameterValue(COMMAND_ERROR_IS_FATAL)
	endif()
	
	dk_getParameter(NO_HALT REMOVE)	
	dk_getParameter(NOECHO  REMOVE)
#	dk_getParameter(NOMERGE REMOVE)
#	if(NOT NOMERGE)
#		dk_mergeFlags("${dk_exec_command}" dk_exec_command)
#	endif()
	
	if(NOT COMMAND)
		list(INSERT dk_exec_command 0 COMMAND)  # insert COMMAND if missing
	endif()
	
#	if(WIN32)
#		dk_validate(cmd.exe "dk_depend(cmd.exe)")
#		if(cmd.exe)
#			if(NOT dk_exec_command MATCHES "cmd;/c")		
#				list(INSERT dk_exec_command 1 "cmd;/c") # add cmd /c if missing
#			endif()
#		endif()
#	endif()
	
	### WORKING_DIRECTORY ###
	# defaults to ${PWD}
	# since CMAKE doesn't use a default PWD or CD current directory, we make our own by keeping
	# the PWD variable updated with the desired path. Any calls to execute_process
	# will use value of that variable unless WORKING_DIRECTORY is specified in the function call.
	if(NOT WORKING_DIRECTORY)
		if(NOT PWD)
			#d_k_chdir(${DIGITALKNOB_DIR})
			#d_k_getcwd()
		else()
			list(APPEND dk_exec_command WORKING_DIRECTORY "${PWD}") # add WORKING_DIRECTORY if missing
		endif()
	endif()
	
	### TIMEOUT ###
#	if(NOT TIMEOUT)
#		set(TIMEOUT 5)
#		list(APPEND dk_exec_command TIMEOUT ${TIMEOUT})
#	endif()
	
	### RESULT_VARIABLE ###
	if(NOT RESULT_VARIABLE)
		set(RESULT_VARIABLE result_variable)
		list(APPEND dk_exec_command RESULT_VARIABLE ${RESULT_VARIABLE})
	endif()
	
	### RESULTS_VARIABLE ###
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.10")
		if(NOT RESULTS_VARIABLE)
			set(RESULTS_VARIABLE results_variable)
			list(APPEND dk_exec_command RESULTS_VARIABLE ${RESULTS_VARIABLE})
		endif()
	endif()
	
	### OUTPUT_VARIABLE ###
	if(NOT OUTPUT_VARIABLE)
		set(OUTPUT_VARIABLE output_variable)
		list(APPEND dk_exec_command OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	else()
		message("OUTPUT_VARIABLE = ${OUTPUT_VARIABLE}")
	endif()
	
	### ERROR_VARIABLE ###
	if(NOT ERROR_VARIABLE)
		set(ERROR_VARIABLE error_variable)
		list(APPEND dk_exec_command ERROR_VARIABLE ${ERROR_VARIABLE})
	endif()
	
#	### INPUT_FILE ###
#	if(NOT INPUT_FILE)
#		set(INPUT_FILE input_file,txt)
#		list(APPEND dk_exec_command INPUT_FILE ${INPUT_FILE})
#	endif()
	
#	### OUTPUT_FILE ###
#	if(NOT OUTPUT_FILE)
#		set(OUTPUT_FILE output_file.txt)
#		list(APPEND dk_exec_command OUTPUT_FILE ${OUTPUT_FILE})
#	endif()
	
	### ERROR_FILE ###
#	if(NOT ERROR_FILE)
#		set(ERROR_FILE error_file.txt)
#		list(APPEND dk_exec_command ERROR_FILE ${ERROR_FILE})
#	endif()
	
	### OUTPUT_QUIET ###
#	if(NOT OUTPUT_QUIET)
#		list(APPEND dk_exec_command OUTPUT_QUIET)
#	endif()
	
	### ERROR_QUIET ###
#	if(NOT ERROR_QUIET)
#		list(APPEND dk_exec_command ERROR_QUIET)
#	endif()
	
	### COMMAND_ECHO ###
	if("${dk_exec_ECHO}")
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
			if(NOT COMMAND_ECHO)
				list(APPEND dk_exec_command COMMAND_ECHO ${dk_exec_ECHO})
			endif()
		else()
			dk_error("COMMAND_ECHO requires CMake version 3.15+")
		endif()
	endif()
	
	### OUTPUT_STRIP_TRAILING_WHITESPACE ###
	if(NOT OUTPUT_STRIP_TRAILING_WHITESPACE)
		list(APPEND dk_exec_command OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
	
	### ERROR_STRIP_TRAILING_WHITESPACE ###
	if(NOT ERROR_STRIP_TRAILING_WHITESPACE)
		list(APPEND dk_exec_command ERROR_STRIP_TRAILING_WHITESPACE)
	endif()
	
	### ENCODING ###
	if("${dk_exec_ENCODING}")
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.8")
			if(NOT ENCODING)
				list(APPEND dk_exec_command ENCODING ${dk_exec_ENCODING})
			endif()
		else()
			dk_error("ECHO_OUTPUT_VARIABLE requires CMake version 3.8+")
		endif()
	endif()
	
	### ECHO_OUTPUT_VARIABLE ###
	if("${dk_exec_ECHO_OUTPUT}" EQUAL 1)
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
			if(NOT ECHO_OUTPUT_VARIABLE)
				list(APPEND dk_exec_command ECHO_OUTPUT_VARIABLE)
			endif()
		else()
			dk_error("ECHO_OUTPUT_VARIABLE requires CMake version 3.18+")
		endif()
	endif()
	
	### ECHO_ERROR_VARIABLE ###
	if("${dk_exec_ECHO_ERROR}" EQUAL 1)
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.18")
			if(NOT ECHO_ERROR_VARIABLE)
				list(APPEND dk_exec_command ECHO_ERROR_VARIABLE)
			endif()
		else()
			dk_error("ECHO_ERROR_VARIABLE requires CMake version 3.18+")
		endif()
	endif()
	
	### COMMAND_ERROR_IS_FATAL ###
	if("${dk_exec_ERROR_IS_FATAL}")
		if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.19")
			if(NOT COMMAND_ERROR_IS_FATAL)
				list(APPEND dk_exec_command COMMAND_ERROR_IS_FATAL ${dk_exec_ERROR_IS_FATAL})
			endif()
		else()
			dk_error("COMMAND_ERROR_IS_FATAL requires CMake version 3.19+")
		endif()
	endif()
	
	
	###################################################################################################
	
#	dk_reparseCmakeCommand(dk_exec_command) # support longer command lines
	
	if("${dk_exec_PRINT_CALL}" EQUAL 1)
		dk_echo("${lblue}dk_exec_call${clr}     = '${dk_exec_call}'")
	endif()
	
	if("${dk_exec_PRINT_COMMAND}" EQUAL 1)
		dk_echo("${lblue}dk_exec_command${clr}  = '${dk_exec_command}'")
	endif()
	
	execute_process(${dk_exec_command})
	
	dk_sleep(1) # wait 1 second1 for the stdout to flush before printing
	
	set(dk_exec_exitcode	"${${RESULT_VARIABLE}}")
	set(dk_exec_exitcodes	"${${RESULTS_VARIABLE}}")
	set(dk_exec_stderr		"${${ERROR_VARIABLE}}")
	set(dk_exec_stdout		"${${OUTPUT_VARIABLE}}")
	
	### process the return value (dk_exec) ###
	string(FIND "${dk_exec_stdout}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
	if(last_newline_pos GREATER -1)
		string(SUBSTRING "${dk_exec_stdout}" ${last_newline_pos} -1 dk_exec) # Extract the last line
	else()
		set(dk_exec ${dk_exec_stdout})
	endif()
	string(STRIP "${dk_exec}" dk_exec)
	
	set(dk_exec_call		${dk_exec_call}			PARENT_SCOPE)		# Prints current command with the arguments dk_exec ws called with (input)
	set(dk_exec_command		${dk_exec_command}		PARENT_SCOPE)		# Prints current command with final arguments before execute_process is called
	set(dk_exec_exitcode	${dk_exec_exitcode}		PARENT_SCOPE)		# Prints current command exitcode.
	set(dk_exec_exitcodes	${dk_exec_exitcodes}	PARENT_SCOPE)		# Prints current commands exitcodes.
	set(dk_exec_stderr		${dk_exec_stderr}		PARENT_SCOPE)		# Prints the stderr output from the command.
	set(dk_exec_stdout		${dk_exec_stdout}		PARENT_SCOPE)		# Prints the stdout output from the command.
	set(dk_exec				${dk_exec}				PARENT_SCOPE)		# Prints the last line of stdout from the command.
	
	if(${RESULT_VARIABLE})
		set(${RESULT_VARIABLE}  ${dk_exec_exitcode}		PARENT_SCOPE)
	endif()
	if(${RESULTS_VARIABLE})
		set(${RESULTS_VARIABLE} ${dk_exec_exitcodes}	PARENT_SCOPE)
	endif()
	if(${ERROR_VARIABLE})
		set(${ERROR_VARIABLE}   ${dk_exec_stderr}		PARENT_SCOPE)
	endif()
	if(${OUTPUT_VARIABLE})
		set(${OUTPUT_VARIABLE}  ${dk_exec_stdout}		PARENT_SCOPE)
	endif()
#	if(${OUTPUT})
#		set(${OUTPUT}  			${dk_exec}				PARENT_SCOPE)
#	endif()
	
	
	if("${dk_exec_PRINT_EXITCODE}" EQUAL 1)
		dk_echo("${lblue}dk_exec_exitcode${clr}  = '${dk_exec_exitcode}'")
	endif()
	if("${dk_exec_PRINT_EXITCODES}" EQUAL 1)
		dk_echo("${lblue}dk_exec_exitcodes${clr} = '${dk_exec_exitcodes}'")
	endif()
	if("${dk_exec_PRINT_STDERR}" EQUAL 1)
		dk_echo("${lblue}dk_exec_stderr${clr}    = '${dk_exec_stderr}'")
	endif()
	if("${dk_exec_PRINT_STDOUT}" EQUAL 1)
		dk_echo("${lblue}dk_exec_stdout${clr}    = '${dk_exec_stdout}'")
	endif()
	if("${dk_exec_PRINT_OUTPUT}" EQUAL 1)
		dk_echo("${lblue}dk_exec${clr}           = '${dk_exec}'")
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
#	dk_exec(echo "Hello World")
#	dk_exec(dir)
#	dk_exec(where curl)
	dk_exec(where curl OUTPUT_VARIABLE curl.exe)
	dk_echo("curl.exe          = ${curl.exe}")

	dk_echo("dk_exec_call      = ${dk_exec_call}")
	dk_echo("dk_exec_command   = ${dk_exec_command}")
	dk_echo("dk_exec_exitcodes = ${dk_exec_exitcodes}")
	dk_echo("dk_exec_exitcode  = ${dk_exec_exitcode}")
	dk_echo("dk_exec_stderr    = ${dk_exec_stderr}")
	dk_echo("dk_exec_stdout    = ${dk_exec_stdout}")
	dk_echo("dk_exec           = ${dk_exec}")
endfunction()
