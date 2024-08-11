include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include(${DKCMAKE_FUNCTIONS_DIR}/dk_debugFunc.cmake)
#include_guard()

###############################################################################
# dk_if(condition... "code")
#
#	@condition  - The input args to be evaluated
#	@code	   - The code to run if the condition is true."
#
macro(dk_if)
	dk_debugFunc(${ARGV})
	
	set(n 0)
	unset(argv)
	list(APPEND argv ${ARGV})
	list(POP_BACK argv code)
	foreach(arg ${argv})
		set(arg${n} ${arg})
		math(EXPR n "${n}+1")
	endforeach()
	while(arg${n})
		unset(arg${n})
		math(EXPR n "${n}+1")
	endwhile()

	if(${arg0} ${arg1} ${arg2} ${arg3} ${arg4} ${arg5} ${arg6} ${arg7} ${arg8} ${arg9})
		dk_eval("${code}")
	else()
		#message("${argv} = false")
	endif()
endmacro()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	set(TEST_VAR 0)
	dk_if(TRUE					"message('dk_if(TRUE) = true')")
	dk_if(TEST_VAR 				"message('TEST_VAR is true')")
	dk_if(DEFINED TEST_VAR 		"message('TEST_VAR is defined')")
	dk_if(NOT DEFINED TEST_VAR 	"message('TEST_VAR is NOT defined')")
	dk_if(${TEST_VAR} EQUAL 1 	"message('TEST_VAR is EQUAL to 1')")
	dk_if(NOT DEFINED ENABLE_dk_debug "set(ENABLE_dk_debug 1 CACHE INTERNAL '')")
endfunction()
