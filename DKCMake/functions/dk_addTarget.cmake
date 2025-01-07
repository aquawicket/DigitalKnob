#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_addTarget(<plugin> <target>)
#
#	<plugin>	- TODO
#	<target>	- TODO
#
function(dk_addTarget)
	dk_debugFunc(2)
	set(plugin ${ARGN0})
	set(target ${ARGN1})
	
	
	if(target)
		if(${plugin}_targets_OFF)
			list(REMOVE_ITEM ${plugin}_targets_OFF ${target})
		endif()
		if(${plugin}_targets)
			dk_set(${plugin}_targets ${${plugin}_targets} ${target})
		else()
			dk_set(${plugin}_targets ${target})
		endif()
	endif()
	
	if(${plugin}_all)
		dk_set(${plugin}_${target} ON)
		#dk_set(${plugin}::${target} ON) # TESTME
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addTarget(plugin target) # TODO
endfunction()