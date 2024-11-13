#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_readOnlyCallback(VAR access value current_list_file stack)
#
#	TODO
#
#	@VAR				- TODO
#	@access:			- TODO
# 	@value:				- TODO
#	@current_list_file:	- TODO
#	@stack:				- TODO
#	 
macro(dk_readOnlyCallback VAR access value current_list_file stack)   # Watcher for readonly property.
	dk_debugFunc()
	
	if ("${access}" STREQUAL "MODIFIED_ACCESS")
		dk_notice("'${VAR}' is READONLY")
		set(${VAR} "${_${VAR}_readonly_val}")	# Restore a value of the variable to the initial one.
	endif()
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()