#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_Target_Config()
#
#	This is where the CMakeLists.txt or configure file is located in a plugin
#
#	SINGLE_CONFIG:	zlib-master/Windows_X86_64_Clang/Debug/CMakeLists.txt	Target_Config = Windows_X86_64_Clang/Debug
#   MULTI_CONFIG:	zlib-master/Windows_X86_64_Msvc/CMakeLists.txt			Target_Config = Windows_X86_64_Msvc
#
#	SINGLE_CONFIG:	zlib-master/Windows_X86_64_Clang/Debug					Target_Build = Windows_X86_64_Clang/Debug
#	MULTI_CONFIG:	zlib-master/Windows_X86_64_Msvc/Debug			 		Target_Build = Windows_X86_64_Msvc/Debug
#
function(dk_Target_Config)
	dk_debugFunc(0)
	
	dk_validate(Target_Type  	"dk_Target_Type()")
	
	###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
	get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
	
	### MULTI_CONFIG ###
	if(MULTI_CONFIG)
		if(CMAKE_BUILD_TYPE)
			dk_error("multi-config generators don't use CMAKE_BUILD_TYPE")
		endif()
		
		dk_set(MULTI_CONFIG 1)
		dk_unset(SINGLE_CONFIG)
		
		dk_validate(Target_Tuple	"dk_Target_Tuple()")
		dk_set(Target_Config ${Target_Tuple})
		
		dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
		dk_debug("*** ${CMAKE_GENERATOR}: Generator is MULTI_CONFIG (${CMAKE_CONFIGURATION_TYPES}) ***")
		dk_assertVar(MULTI_CONFIG)
		dk_assertVar(Target_Config)
		
	### SINGLE_CONFIG ###
	else()
		if(CMAKE_CONFIGURATION_TYPES)
			dk_error("single-config generators don't use CMAKE_CONFIGURATION_TYPES")
		endif()
		
		dk_set(SINGLE_CONFIG 1)
		dk_unset(MULTI_CONFIG)
		dk_validate(Target_Tuple	"dk_Target_Tuple()")
		if(Debug)
			dk_set(CMAKE_BUILD_TYPE Debug)
			dk_set(Target_Config ${Target_Tuple}/${Debug_Dir})
		elseif(Release)
			dk_set(CMAKE_BUILD_TYPE Release)
			dk_set(Target_Config ${Target_Tuple}/${Release_Dir})
		endif()
		
		dk_assertVar(SINGLE_CONFIG)
		dk_assertVar(CMAKE_BUILD_TYPE)
		dk_assertVar(Target_Config)
		dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
		dk_debug("*** ${CMAKE_GENERATOR}: Generator is SINGLE_CONFIG (${CMAKE_BUILD_TYPE}) ***")
	endif()
	
	### Target_Build ###
	if(Debug)
		dk_set(Target_Build   ${Target_Tuple}/${Debug_Dir})
	elseif(Release)
		dk_set(Target_Build   ${Target_Tuple}/${Release_Dir})
	endif()
	dk_assertVar(Target_Build)
	
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_Target_Config()
endfunction()
