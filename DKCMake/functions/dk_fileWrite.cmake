include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# dk_fileWrite(<file> <string>)
#
#
function(dk_fileWrite path str) 
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_error("${CMAKE_CURRENT_FUNCTION}(): incorrect number of arguments")
	endif()
	
	file(WRITE ${path} "${str}")

endfunction()




macro(DKTEST) ########################################################################
	
	dk_fileWrite("dk_fileWrite_TEST.txt" "string written by dk_fileWrite")
endmacro()