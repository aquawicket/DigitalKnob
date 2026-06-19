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


#########################################################################
# dk_if(condition... "code")
#
#	@condition  - The input args to be evaluated
#	@code	    - The code to run if the condition is true."
#
macro(dk_if)
	#d#k_debugFunc()
	
	set(n 0)
	unset(argv)
	list(APPEND argv ${ARGV})
	
	if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.15")
		list(POP_BACK argv code)
	else()
		list(LENGTH argv argv_length)
		math(EXPR argv_last_index "${argv_length} - 1")
		list(GET argv ${argv_last_index} code)
		list(REMOVE_AT argv ${argv_last_index})
	endif()
	
	foreach(arg ${argv})
		set(arg${n} ${arg})
		math(EXPR n "${n}+1")
	endforeach()
	while(arg${n})
		unset(arg${n})
		math(EXPR n "${n}+1")
	endwhile()

	if(${arg0} ${arg1} ${arg2} ${arg3} ${arg4} ${arg5} ${arg6} ${arg7} ${arg8} ${arg9})
		if(NOT COMMAND dk_eval)
			include("$ENV{DKCMAKE_FUNCTIONS_DIR_}dk_eval.cmake")
		endif()
		dk_eval("${code}")
	else()
		#dk_debug("${argv} = false")
	endif()
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(TEST_VAR 0)
	dk_if(TRUE					"dk_echo(\"dk_if(TRUE) = true\")")
	dk_if(TEST_VAR 				"dk_echo(\"TEST_VAR is true\")")
	dk_if(DEFINED TEST_VAR 		"dk_echo(\"TEST_VAR is defined\")")
	dk_if(NOT DEFINED TEST_VAR 	"dk_echo(\"TEST_VAR is NOT defined\")")
	dk_if(${TEST_VAR} EQUAL 1 	"dk_echo(\"TEST_VAR is EQUAL to 1\")")
	dk_if(NOT DEFINED ENABLE_dk_debug "set(ENABLE_dk_debug 1 CACHE INTERNAL \"\")")
endfunction()
