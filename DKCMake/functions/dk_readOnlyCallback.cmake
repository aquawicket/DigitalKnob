include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

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
	dk_debugFunc(${ARGV})
	
	if ("${access}" STREQUAL "MODIFIED_ACCESS")
		dk_notice("'${VAR}' is READONLY")
		set(${VAR} "${_${VAR}_readonly_val}")	# Restore a value of the variable to the initial one.
	endif()
endmacro()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)