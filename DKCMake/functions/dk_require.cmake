#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_require(plugin)
#
#	Require a plugin, return if plugin unavailable
#
#	@plugin				- TODO
#	@target (optional)	- TODO
#
# FIXME
macro(dk_require plugin)
	dk_debugFunc()
	
	if(plugin IN_LIST dk_disabled_list)
		dk_basename(${CMAKE_CURRENT_LIST_DIR} Lib)
		dk_notice("${Lib} requires ${plugin} which is DISABLED")
		dk_notice("DISABLING ${Lib}")
		dk_disable(${Lib})
		dk_return()
	endif()
	dk_depend(${plugin})
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()