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
# dk_CONFIG_PATH()
#
#
function(dk_CONFIG_PATH)
	dk_debugFunc()
	
	dk_validate(Target_Type  	"dk_Target_Type()") # get {Debug} {Release}
	dk_printVar(Target_Type)
	dk_validate(Target_Tuple   "dk_Target_Tuple()")	# get {Target_Tuple}
	
	###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
	get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
	if(MULTI_CONFIG)
		if(CMAKE_BUILD_TYPE)
			dk_error("multi-config generators don't use CMAKE_BUILD_TYPE")
		endif()
		
		dk_set(MULTI_CONFIG 1)
		dk_unset(SINGLE_CONFIG)
		dk_set(CONFIG_PATH ${Target_Tuple})
		if(Debug)
			dk_set(BUILD_PATH   ${Target_Tuple}/${Debug_Dir})
		elseif(Release)
			dk_set(BUILD_PATH   ${Target_Tuple}/${Release_Dir})
		endif()
		dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
		dk_info("*** ${CMAKE_GENERATOR}: Generator is MULTI_CONFIG (${CMAKE_CONFIGURATION_TYPES}) ***")
		
		dk_assertVar(MULTI_CONFIG)
		dk_assertVar(CONFIG_PATH)
		dk_assertVar(BUILD_PATH)
		
	else() # SINGLE_CONFIG
		if(CMAKE_CONFIGURATION_TYPES)
			dk_error("single-config generators don't use CMAKE_CONFIGURATION_TYPES")
		endif()
		
		dk_set(SINGLE_CONFIG 1)
		dk_unset(MULTI_CONFIG)
		if(Debug)
			dk_set	(CMAKE_BUILD_TYPE Debug)
			dk_set	(CONFIG_PATH ${Target_Tuple}/${Debug_Dir})
			dk_set	(BUILD_PATH ${Target_Tuple}/${Debug_Dir})
			
			dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
			dk_info("*** ${CMAKE_GENERATOR}: Generator is SINGLE_CONFIG (${CMAKE_BUILD_TYPE}) ***")
		elseif(Release)
			dk_set	(CMAKE_BUILD_TYPE Release)
			dk_set	(CONFIG_PATH ${Target_Tuple}/${Release_Dir})
			dk_set	(BUILD_PATH ${Target_Tuple}/${Release_Dir})
			
			dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
			dk_info("*** ${CMAKE_GENERATOR}: Generator is SINGLE_CONFIG (${CMAKE_BUILD_TYPE}) ***")
		endif()
		
		dk_assertVar(SINGLE_CONFIG)
		dk_assertVar(CMAKE_BUILD_TYPE)
		dk_assertVar(CONFIG_PATH)
		dk_assertVar(BUILD_PATH)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_CONFIG_PATH()
endfunction()
