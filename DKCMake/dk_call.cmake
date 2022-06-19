##################################################################################
# dk_Call(func)
#
#	load a ${func}.cmake file located in the DKCMake path amd call the function 
#
include(${DIGITALKNOB}/DK/DKCMake/DKLoad.cmake)

macro(dk_call func)
	DKLoad(${func})
	cmake_language(CALL ${func} ${ARGV})
endmacro()
