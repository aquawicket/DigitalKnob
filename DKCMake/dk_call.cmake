include_guard()
include(${DKCMAKE}/dk_load.cmake)

##################################################################################
# dk_Call(func)
#
#	load a ${func}.cmake file located in the DKCMake path amd call the function 
#
macro(dk_call func)
	dk_load(${func})
	cmake_language(CALL ${func} ${ARGV})
endmacro()
