include_guard()
include(${DKCMAKE}/dk_load.cmake)

##################################################################################
# dk_Call(func)
#
#	load a ${func}.cmake file located in the DKCMake path amd call the function and pass arguments
#
#	@func	- TODO
#
macro(dk_call func)
	dk_load(${func})
	cmake_language(CALL ${ARGV}) # cmake 3.18
endmacro()
