#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	dk_debugFunc(0)
	
	dk_todo()
endfunction()