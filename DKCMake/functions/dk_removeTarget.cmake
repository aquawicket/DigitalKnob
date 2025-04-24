#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_removeTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_removeTarget plugin target)
	dk_debugFunc()

	if(${plugin}_targets)
		list(REMOVE_ITEM ${plugin}_targets ${target})
	endif()
	if(${plugin}_targets_OFF)
		dk_set(${plugin}_targets_OFF ${${plugin}_targets_OFF} ${target})
	else()
		dk_set(${plugin}_targets_OFF ${target})
	endif()
	dk_set(${plugin}_${target} 0)
	dk_unset(${plugin}_${target})
	#dk_unset(${plugin}::${target}) # TESTME
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()