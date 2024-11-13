#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_addTarget(<plugin> <target>)
#
#	<plugin>	- TODO
#	<target>	- TODO
#
function(dk_addTarget plugin target)
	dk_debugFunc(2)
	
	if(${plugin}_targets_OFF)
		list(REMOVE_ITEM ${plugin}_targets_OFF ${target})
	endif()
	if(${plugin}_targets)
		dk_set(${plugin}_targets ${${plugin}_targets} ${target})
	else()
		dk_set(${plugin}_targets ${target})
	endif()
	if(${plugin}_all)
		dk_set(${plugin}_${target} ON)
		#dk_set(${plugin}::${target} ON) # TESTME
	endif()
	
# DEBUG
#	TODO
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
	#dk_addTarget(plugin target)
endfunction()