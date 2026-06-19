#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_removeTarget(Plugin target)
#
#	TODO
#
#	@Plugin		- TODO
#	@target		- TODO
#
function(dk_removeTarget Plugin target)
	dk_debugFunc()

	if(${Plugin}_targets)
		list(REMOVE_ITEM ${Plugin}_targets ${target})
	endif()
	if(${Plugin}_targets_OFF)
		dk_set(${Plugin}_targets_OFF ${${Plugin}_targets_OFF} ${target})
	else()
		dk_set(${Plugin}_targets_OFF ${target})
	endif()
	dk_set(${Plugin}_${target} 0)
	dk_unset(${Plugin}_${target})
	#dk_unset(${Plugin}::${target}) # TESTME
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()