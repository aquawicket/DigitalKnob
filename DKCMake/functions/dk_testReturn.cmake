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
# dk_testReturn(input, output)
#
#
function(dk_testReturn)
	dk_debugFunc(1 2)
	
	
	string(REPLACE "input" "output" dk_testReturn "${ARGV0}")
	
	
	###### return ######
	set(dk_testReturn ${dk_testReturn} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_testReturn} PARENT_SCOPE)
	else()
		message(${dk_testReturn})
	endif()

	#return()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	### Result as global variable
	dk_echo()
	dk_testReturn("inputA")
	dk_echo("dk_testReturn = ${dk_testReturn}")
	
	### Result as parameter
	dk_echo()
	dk_testReturn("inputB" resultB)
	dk_echo("resultB = ${resultB}")
	dk_echo("dk_testReturn = ${dk_testReturn}")
	
	### NOTE: Cmake has no return value
	### Result as return value
	#dk_echo()
	#resultC=$(dk_testReturn "inputC");
	#dk_echo("resultC = ${resultC}")
	#dk_echo "dk_testReturn = ${dk_testReturn}";					#NOTE: export cannot be seen outside of command substituion
endfunction()