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
# dk_addTarget(<Plugin> <target>)
#
#	<Plugin>	- TODO
#	<target>	- TODO
#
function(dk_addTarget)
	dk_debugFunc(2)
	set(Plugin ${ARGN0})
	set(target ${ARGN1})
	
	
	if(target)
		if(${Plugin}_targets_OFF)
			list(REMOVE_ITEM ${Plugin}_targets_OFF ${target})
		endif()
		if(${Plugin}_targets)
			dk_set(${Plugin}_targets ${${Plugin}_targets} ${target})
		else()
			dk_set(${Plugin}_targets ${target})
		endif()
	endif()
	
	if(${Plugin}_all)
		dk_set(${Plugin}_${target} ON)
		#dk_set(${Plugin}::${target} ON) # TESTME
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addTarget(Plugin target) # TODO
endfunction()