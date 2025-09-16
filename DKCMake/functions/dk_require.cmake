#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_require(Plugin)
#
#	Require a Plugin, return if Plugin unavailable
#
#	@Plugin				- TODO
#	@target (optional)	- TODO
#
# FIXME
macro(dk_require Plugin)
	dk_debugFunc()
	
	if(Plugin IN_LIST dkdisabled_list)
		dk_basename(${CMAKE_CURRENT_LIST_DIR} Lib)
		dk_notice("${Lib} requires ${Plugin} which is DISABLED")
		dk_notice("DISABLING ${Lib}")
		dk_disable(${Lib})
		dk_return()
	endif()
	dk_depend(${Plugin})
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()