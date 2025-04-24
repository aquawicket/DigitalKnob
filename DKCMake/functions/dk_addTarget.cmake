#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_addTarget(<plugin> <target>)
#
#	<plugin>	- TODO
#	<target>	- TODO
#
<<<<<<< HEAD
function(dk_addTarget plugin target)
	dk_debugFunc()
	
	if(${plugin}_targets_OFF)
		list(REMOVE_ITEM ${plugin}_targets_OFF ${target})
	endif()
	if(${plugin}_targets)
		dk_set(${plugin}_targets ${${plugin}_targets} ${target})
	else()
		dk_set(${plugin}_targets ${target})
	endif()
=======
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
	
>>>>>>> Development
	if(${plugin}_all)
		dk_set(${plugin}_${target} ON)
		#dk_set(${plugin}::${target} ON) # TESTME
	endif()
<<<<<<< HEAD
	
# DEBUG
#	TODO
=======
>>>>>>> Development
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
	#dk_addTarget(plugin target)
=======
	dk_debugFunc(0)
	
	dk_addTarget(plugin target) # TODO
>>>>>>> Development
endfunction()