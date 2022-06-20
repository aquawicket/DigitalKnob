include_guard()

##################################################################################
# dk_Call(func)
#
#	load a ${func}.cmake file located in the DKCMake path amd call the function 
#
include(${DIGITALKNOB}/DK/DKCMake/dk_load.cmake)

macro(dk_call func)
	dk_load(${func})
	cmake_language(CALL ${func} ${ARGV})
endmacro()
