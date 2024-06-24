include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# __ARGC__(rtn_var, frame)
#
#
macro(__ARGC__ rtn_var)
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()

	set(${rtn_var} ${ARGC})
endmacro()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	#dk_debugFunc
	
	__ARGC__(ARGC)
	dk_info("\${ARGC} = ${ARGC}")
	
	__ARGC__(ARGC_0 0)
	dk_info("\${ARGC_0} = ${ARGC_0}")
	
	__ARGC__(ARGC_1 1)
	dk_info("\${ARGC_1} = ${ARGC_1}")

endfunction()