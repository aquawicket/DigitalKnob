include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# __LINE__(rtn_var, frame)
#
#
macro(__LINE__ rtn_var)
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()

	set(${rtn_var} "${CMAKE_CURRENT_LIST_LINE}")
	#set(${rtn_var} "${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
endmacro()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	#dk_debugFunc
	
	__LINE__(_LINE_)
	dk_echo("\${_LINE_} = ${_LINE_}")
	
	__LINE__(_LINE_0 0)
	dk_echo("\${_LINE_0} = ${_LINE_0}")

	__LINE__(_LINE_1 1)
	dk_echo("\${_LINE_1} = ${_LINE_1}")

endfunction(DKTEST)
