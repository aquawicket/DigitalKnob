#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_undefine(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_undefine str)
	dk_debugFunc()
	
	remove_definitions(${str})
	if(NOT DKDEFINES_LIST)
		dk_return()
	endif()
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
	dk_set(DKDEFINES_LIST ${DKDEFINES_LIST})	# Globalize the variable
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()