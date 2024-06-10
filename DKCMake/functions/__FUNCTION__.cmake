include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# __FUNCTION__(rtn_var, frame)
#
#
macro(__FUNCTION__ rtn_var)
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()

	set(${rtn_var} "${CMAKE_CURRENT_FUNCTION}")
endmacro()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	#dk_debugFunc
	
	__FUNCTION__(_FUNCTION_)
	dk_echo("\${_FUNCTION_} = ${_FUNCTION_}")
	
	__FUNCTION__(_FUNCTION_0 0)
	dk_echo("\${_FUNCTION_0} = ${_FUNCTION_0}")

	__FUNCTION__(_FUNCTION_1 1)
	dk_echo("\${_FUNCTION_1} = ${_FUNCTION_1}")

endfunction(DKTEST)