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
dk_set(dk_callDKBatch_PRINT_CALL 1)
dk_set(dk_callDKBatch_PRINT_COMMAND 1)
dk_set(dk_callDKBatch_PRINT_RESULT 1)
dk_set(dk_callDKBatch_PRINT_OUTPUT 1)
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

	dk_validate(CMD_EXE 					"dk_CMD_EXE()")
	dk_validate(DKBATCH_FUNCTIONS_DIR_		"dk_DKBRANCH_DIR()")
	set(dk_callDKBatch_CALL "${func}(${args})")
	set(dk_callDKBatch_COMMAND ${CMD_EXE} /V:ON /c ${DKBATCH_FUNCTIONS_DIR_}${func}.cmd ${args} & echo !${func}!)

	if("${dk_callDKBatch_PRINT_CALL}" EQUAL 1)
		dk_echo("${lblue}dk_callDKBatch_CALL${clr} = '${dk_callDKBatch_CALL}'")
	endif()
	if("${dk_callDKBatch_PRINT_COMMAND}" EQUAL 1)
		dk_echo("${lblue}dk_callDKBatch_COMMAND${clr} = '${dk_callDKBatch_COMMAND}'")
	endif()

	dk_exec(${dk_callDKBatch_COMMAND} WORKING_DIRECTORY "${DKBATCH_FUNCTIONS_DIR}")
	
	if("${dk_callDKBatch_PRINT_RESULT}" EQUAL 1)
		dk_echo("${lblue}dk_exec_exitcode${clr}  = '${dk_exec_exitcode}'")
	endif()
	if("${dk_callDKBatch_PRINT_OUTPUT}" EQUAL 1)
		if(NOT "${dk_exec}" STREQUAL "!${func}!")
			dk_echo("${lblue}dk_exec${clr}  = '${dk_exec}'")
		endif()
	endif()
	
	if(NOT "${dk_exec}" STREQUAL "!${func}!")
		set(dk_callDKBatch "${dk_exec}" PARENT_SCOPE)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_callDKBatch(dk_title "#########################################################################")
	
#	dk_callDKBatch(dk_test "abc" "1 2 4")
#	if(dk_callDKBatch)
#		dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
#	endif()
	
#	dk_callDKBatch(dk_urlExists "http://www.google.com/index.html")
#	if(dk_callDKBatch)
#		dk_echo("dk_callDKBatch = ${dk_callDKBatch}")
#	endif()
	
#	dk_callDKBatch(dk_urlExists "http://www.nonExistentURL/fjafjkasfjas;d")
#	if(dk_callDKBatch)
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
