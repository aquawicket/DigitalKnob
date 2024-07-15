include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# __FUNCTION__(rtn_var, frame)
#
#
macro(__FUNCTION__ rtn_var)
	if(NOT DEFINED FUNCNAME)
		set(${rtn_var} "CMAKE_CURRENT_LIST_FUNCTION: ${CMAKE_CURRENT_LIST_FUNCTION}")
	else()
		if(ARGV1)
			set(index ${ARGV1})
		else()
			set(index 0)
		endif()
#		#math(EXPR index "${index}+1" OUTPUT_FORMAT DECIMAL)	
		
		list(LENGTH FUNCNAME FUNCNAME_LENGTH)
		if(${index} GREATER ${FUNCNAME_LENGTH})
			dk_echo(FATAL_ERROR "index:${index} out of range:${FUNCNAME_LENGTH}")
		endif()
		list(GET FUNCNAME ${index} ${rtn_var})
	endif()
endmacro()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	#dk_debugFunc
	list(LENGTH FUNCNAME FUNCNAME_LENGTH)
	dk_echo("FUNCNAME:${FUNCNAME_LENGTH} = ${FUNCNAME}")
	__FUNCTION__(_func_)
	dk_info("\${_func_} = ${_func_}")
	
	__FUNCTION__(_func0_ 0)
	dk_info("\${_func0_} = ${_func0_}")

	__FUNCTION__(_func1_ 1)
	dk_info("\${_func1_} = ${_func1_}")
	
	__FUNCTION__(_func2_ 2)
	dk_info("\${_func2_} = ${_func2_}")

	list(LENGTH FUNCNAME FUNCNAME_LENGTH)
	dk_echo("FUNCNAME:${FUNCNAME_LENGTH} = ${FUNCNAME}")

endfunction()