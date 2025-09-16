#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

#########################################################################
#dk_set(dk_callDKBatch_PRINT_CALL			1) 		# dk_callDKBatch_call
#dk_set(dk_callDKBatch_PRINT_COMMAND		1) 		# dk_callDKBatch_command
#dk_set(dk_callDKBatch_PRINT_EXITCODES		1)		# dk_callDKBatch_exitcodes
#dk_set(dk_callDKBatch_PRINT_EXITCODE 		1)		# dk_callDKBatch_exitcode
#dk_set(dk_callDKBatch_PRINT_STDERR 		1)		# dk_callDKBatch_stderr[]
#dk_set(dk_callDKBatch_PRINT_STDOUT			1)		# dk_callDKBatch_stdout[]
#dk_set(dk_callDKBatch_PRINT_OUTPUT 		1)		# dk_callDKBatch
#########################################################################
# dk_callDKBatch(<func>, <args...>)
#
#

function(dk_callDKBatch func)
	dk_debugFunc(1 99)

	set(args ${ARGN})
	#dk_replaceAll("${args}" "(" "#40" args)
	#dk_replaceAll("${args}" ")" "#41" args)

#	if("${dk_callDKBatch_PRINT_OUTPUT}" EQUAL 1)
#		set(ECHO_OUTPUT_VARIABLE "ECHO_OUTPUT_VARIABLE")
#	endif()

	dk_validate(cmd_exe "dk_depend(cmd)")
	dk_validate(DKBATCH_FUNCTIONS_DIR_		"dk_DKBRANCH_DIR()")
	set(dk_callDKBatch_call "${func}(${args})")
	set(dk_callDKBatch_command ${cmd_exe} /V:ON /c ${DKBATCH_FUNCTIONS_DIR_}${func}.cmd ${args} & if defined ${func} echo !${func}!)

	if("${dk_callDKBatch_PRINT_CALL}" EQUAL 1)
		dk_echo("${lblue}dk_callDKBatch_call${clr} = '${dk_callDKBatch_call}'")
	endif()
	if("${dk_callDKBatch_PRINT_COMMAND}" EQUAL 1)
		dk_echo("${lblue}dk_callDKBatch_command${clr} = '${dk_callDKBatch_command}'")
	endif()

	dk_exec(${dk_callDKBatch_command} WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}")
	set(dk_callDKBatch_call 		"${dk_exec_call}" 		PARENT_SCOPE)
	set(dk_callDKBatch_command 		"${dk_exec_command}" 	PARENT_SCOPE)
	set(dk_callDKBatch_exitcodes 	"${dk_exec_exitcodes}" 	PARENT_SCOPE)
	set(dk_callDKBatch_exitcode 	"${dk_exec_exitcode}" 	PARENT_SCOPE)
	set(dk_callDKBatch_stderr 		"${dk_exec_stderr}" 	PARENT_SCOPE)
	set(dk_callDKBatch_stdout 		"${dk_exec_stdout}" 	PARENT_SCOPE)
	set(dk_callDKBatch		 		"${dk_exec}" 			PARENT_SCOPE)

	if("${dk_callDKBatch_PRINT_EXITCODE}" EQUAL 1)
		#if(NOT "${dk_exec_exitcode}" STREQUAL "")
			dk_echo("${lblue}dk_callDKBatch_exitcode${clr} = '${dk_exec_exitcode}'")
		#endif
	endif()
	if("${dk_callDKBatch_PRINT_EXITCODES}" EQUAL 1)
		#if(NOT "${dk_exec_exitcodes}" STREQUAL "")
			dk_echo("${lblue}dk_callDKBatch_exitcodes${clr} = '${dk_exec_exitcodes}'")
		#endif()
	endif()
	if("${dk_callDKBatch_PRINT_STDERR}" EQUAL 1)
		#if(NOT "${dk_exec_stderr}" STREQUAL "")
			dk_echo("${lblue}dk_callDKBatch_stderr${clr}   = '${dk_exec_stderr}'")
		#endif()
	endif()
	if("${dk_callDKBatch_PRINT_STDOUT}" EQUAL 1)
		#if(NOT "${dk_exec_stdout}" STREQUAL "")
			dk_echo("${lblue}dk_callDKBatch_stdout${clr}   = '${dk_exec_stdout}'")
		#endif()
	endif()
	if("${dk_callDKBatch_PRINT_OUTPUT}" EQUAL 1)
		#if(NOT "${dk_exec}" STREQUAL "")
			dk_echo("${lblue}dk_callDKBatch${clr}          = '${dk_exec}'")
		#endif()
	endif()

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_callDKBatch(dk_killProcess "gpg-agent.exe")
	
#	dk_callDKBatch(dk_title "#########################################################################")
	
#	dk_callDKBatch(dk_test "abc" "1 2 4")
#	if(dk_callDKBatch)
#		dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
#	endif()
	
#	dk_callDKBatch(dk_urlExists "http://www.google.com/index.html")
#	if(${dk_callDKBatch})
#		dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
#	endif()
	
#	dk_callDKBatch(dk_urlExists "http://www.nonExistentURL/fjafjkasfjas;d")
#	if(${dk_callDKBatch})
#		dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
#	endif()
	
	#dk_callDKBatch(dk_test "abc" "1 2 4")
	#dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
	
	#dk_callDKBatch(dk_test "$ENV{SystemDrive}/Program Files (x86)/Edrum Monitor/EdrumMon.exe" "dk_callDKBatch.cmake")
	#dk_echo("dk_callDKBatch = ${dk_callDKBatch}")

	#dk_callDKBatch(dk_firewallAllow "Edrum Monitor" "$ENV{SystemDrive}/ProgramFiles (x86)/Edrum Monitor/EdrumMon.exe")
	#dk_echo("dk_callDKBatch = ${dk_callDKBatch}")

	#dk_callDKBatch(dk_registryKeyExists rtn_var "HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/CurrentVersion/Uninstall/QEMU")
	#dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
endfunction()
