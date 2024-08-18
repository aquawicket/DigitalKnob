include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_undefine(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_undefine str)
	dk_debugFunc(${ARGV})
	
	remove_definitions(${str})
	if(NOT DKDEFINES_LIST)
		return()
	endif()
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()