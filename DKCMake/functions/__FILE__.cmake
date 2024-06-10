include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# __FILE__(rtn_var, frame)
#
#
macro(__FILE__ rtn_var)
	if(${ARGV1})
		set(_FRAME_ ${ARGV1})
	else()
		set(_FRAME_ 0)
	endif()
	math(EXPR _FRAME_ "${_FRAME_}+1" OUTPUT_FORMAT DECIMAL)

	set(${rtn_var} "${CMAKE_CURRENT_LIST_FILE}")
endmacro()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	#dk_debugFunc
	
	__FILE__(FILE)
	dk_echo("\${FILE} = ${FILE}")
	
	__FILE__(FILE_0 0)
	dk_echo("\${FILE_0} = ${FILE_0}")

	__FILE__(FILE_1 1)
	dk_echo("\${FILE_1} = ${FILE_1}")

endfunction(DKTEST)