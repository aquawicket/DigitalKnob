include_guard()

##################################################################################
# dk_fileAppend(<file> <string>)
#
#
function(dk_fileAppend path str) 
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_error("${CMAKE_CURRENT_FUNCTION}(): incorrect number of arguments")
	endif()
	
	file(APPEND ${path} "${str}")

endfunction()




macro(DKTEST) ########################################################################
	
	dk_fileAppend("dk_fileAppend_TEST.txt" "string written by dk_fileAppend")
endmacro()