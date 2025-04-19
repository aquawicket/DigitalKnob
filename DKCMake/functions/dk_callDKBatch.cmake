#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

if(NOT DEFINED dk_callDKBatch_PRINT_COMMAND)
	dk_set(dk_callDKBatch_PRINT_COMMAND 0)
endif()
if(NOT DEFINED dk_callDKBatch_PRINT_OUTPUT)
	dk_set(dk_callDKBatch_PRINT_OUTPUT 0)
endif()
##################################################################################
# dk_callDKBatch(<func>, <args...>)
#
#

function(dk_callDKBatch func)
	dk_debugFunc(1 99)

	#set(func "${ARGV0}")
	set(args ${ARGN})
	#dk_replaceAll("${args}" "(" "#40" args)
	#dk_replaceAll("${args}" ")" "#41" args)

	### get ALL_BUT_FIRST_ARGS ###
	#set(ALL_BUT_FIRST_ARGS                  ${ARGN})
	### get LAST_ARG ###
	#list(GET ARGN -1 LAST_ARG)

	if(${dk_callDKBatch_PRINT_OUTPUT} EQUAL 1)
		set(ECHO_OUTPUT_VARIABLE "ECHO_OUTPUT_VARIABLE")
	endif()

	### Call DKBatch function ###
	dk_validate(CMD_EXE "dk_CMD_EXE()")
	dk_validate(ENV{DKBATCH_FUNCTIONS_DIR_}		"dk_DKBRANCH_DIR()")	
	set(DKBATCH_COMMAND ${CMD_EXE} /V:ON /c call cd $ENV{DKBATCH_FUNCTIONS_DIR_} & $ENV{DKBATCH_FUNCTIONS_DIR_}${func}.cmd ${args} & echo !${func}!)

	if("${dk_callDKBatch_PRINT_COMMAND}" EQUAL 1)
		message("DKBATCH_COMMAND = '${DKBATCH_COMMAND}'")
	endif()

	### FIXME ###
	message("\n${DKBATCH_COMMAND}\n")
	execute_process(COMMAND ${DKBATCH_COMMAND} OUTPUT_VARIABLE output_variable ECHO_OUTPUT_VARIABLE RESULT_VARIABLE result_variable WORKING_DIRECTORY "$ENV{DKBATCH_FUNCTIONS_DIR}" OUTPUT_STRIP_TRAILING_WHITESPACE)

	dk_pause()
	
	### process the return value ###
	string(FIND "${output_variable}" "\n" last_newline_pos REVERSE)  # Find the position of the last newline character
	if(last_newline_pos GREATER -1)
		string(SUBSTRING "${output_variable}" ${last_newline_pos} -1 output_variable) # Extract the last line
	endif()
	string(STRIP "${output_variable}" output_variable)

	message("        command = ${DKBATCH_COMMAND}\n")
	message("output_variable = ${output_variable}")
	message("result_variable = ${result_variable}")
	set(dk_callDKBatch "${output_variable}" PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	#execute_process(COMMAND ${CMD_EXE} /c echo "Hello World" OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE)
	#dk_echo("output = ${output}")

	#execute_process(COMMAND ${CMD_EXE} /V:ON /c "set /p input=& echo !input!" OUTPUT_VARIABLE input)
	#dk_echo("input = ${input}")

	dk_callDKBatch(dk_test "abc" "1 2 4")
	dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
	
	dk_callDKBatch(dk_urlExists "http://www.google.com/index.html")
	dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
	
	dk_callDKBatch(dk_urlExists "http://www.nonExistentURL/fjafjkasfjas;d")
	dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
	
	#dk_callDKBatch(dk_test "abc" "1 2 4")
	#dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
	
	#dk_callDKBatch(dk_test "$ENV{SystemDrive}/Program Files (x86)/Edrum Monitor/EdrumMon.exe" "dk_callDKBatch.cmake")
	#dk_echo("dk_callDKBatch = ${dk_callDKBatch}")

	#dk_callDKBatch(dk_firewallAllow "Edrum Monitor" "$ENV{SystemDrive}/ProgramFiles (x86)/Edrum Monitor/EdrumMon.exe")

	#dk_callDKBatch(dk_registryKeyExists rtn_var "HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/CurrentVersion/Uninstall/QEMU")
	#dk_echo("rtn_var = ${rtn_var}")
endfunction()
