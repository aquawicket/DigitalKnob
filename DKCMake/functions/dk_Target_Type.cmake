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

##################################################################################
# dk_Target_Type()
#
#	Target_Type = Debug, Release
#
function(dk_Target_Type)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(Target_Type "${ARGV0}")
	
	###### GET ######	
	elseif(DEFINED ENV{Target_Type})
		dk_set(Target_Type "$ENV{Target_Type}")
	
	else()
		dk_echo()
		if(Target_Type_Cache)
			dk_echo(" 0) ${Target_Type_Cache}")
		endif()
		
		dk_echo()
		dk_echo(" 1) Debug")
		dk_echo(" 2) Release")
		dk_echo(" 3) Go Back")
		dk_echo(" 4) Exit")
		dk_echo()
		
		dk_keyboardInput(input)
		if("${input}" EQUAL "0")
			dk_set(Target_Type ${Target_Type_Cache})
		elseif("${input}" EQUAL "1")
			dk_set(Target_Type "Debug")
		elseif("${input}" EQUAL "2")
			dk_set(Target_Type "Release")
		elseif("${input}" EQUAL "3")
			#dk_unset(dk_pickUpdate)
		elseif("${input}" EQUAL "4")
			dk_exit(0)
		else()
			dk_warning("invalid selection: '${input}'")
		endif()
	endif()
	
	dk_set(${Target_Type} 1)	
	dk_set(${Target_Type}_Target 1)	
	
	###### VALIDATE RESULT ######
	if(Debug)
	elseif(Release)
	else()
		dk_fatal("Target_Type:'${Target_Type}' is INVALID!")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_Target_Type()
	dk_printVar(Target_Type)
	dk_printVar(${Target_Type}_Target)
	
	###### SET ######
	dk_Target_Type("Debug")
	dk_printVar(Target_Type)
	dk_printVar(${Target_Type}_Target)
endfunction()