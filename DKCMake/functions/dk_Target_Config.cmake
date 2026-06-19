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
# dk_Target_Config()
#
#	This is where makefiles and config files are generated to. This is not nessecarily where binary files are compiled to.
#	For example, This is equivelent to cmake's Build_Directory and where it will generate CMakeCache.txt and makefiles.
#   This path may change according to which CMAKE_GENERATOR is used. With SINGLE_CONFIG Generators, this path is the same as the 
#	binary output directory. With MULTI_CONFIG Generators like visual studio, This is where the project files, makefiles, etc are 
#	generated. And unlike SINGLE_CONFIG Generators, binaries will be build into a sub_folder like Debug or Release.
#
#	### CMAKE OUTPUT EXAMPLE ###
#	SINGLE_CONFIG:	
#		Project files -> ${Library}/${Target_Tuple}/Debug/CMakeCache.txt
#		Binary files  -> ${Library}/${Target_Tuple}/Debug/library.a
#   MULTI_CONFIG:	
#		Project files -> ${Library}/${Target_Tuple}/CMakeCache.txt
#		Binary files  -> ${Library}/${Target_Tuple}/Debug/library.a
#
function(dk_Target_Config)
	dk_debugFunc(0)
	
	dk_validate(Target_Tuple  	"dk_Target_Tuple()")
	dk_validate(Target_Type  	"dk_Target_Type()")
	dk_validate(DKCMAKE_DIR 	"dk_DKBRANCH_DIR()")
	dk_load("${DKCMAKE_DIR}/DKVariables.cmake")
	
	dk_CMAKE_GENERATOR()
	
	###### set MULTI_CONFIG / SINGLE_CONFIG variables ######
	get_property(MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
	if(MSVC OR XCODE) # OR Msvc OR Xcode)
		### Target_Config_Type ###
		dk_set(Target_Config_Type 	"MULTI_CONFIG")
		
		### MULTI_CONFIG ###
		dk_set(${Target_Config_Type} 1)
		dk_assertVar(MULTI_CONFIG)
	endif()
	dk_success("CMAKE_GENERATOR = ${CMAKE_GENERATOR}")
	dk_success("MULTI_CONFIG = ${MULTI_CONFIG}")
	
	### MULTI_CONFIG ###
	if(MULTI_CONFIG)
		### Unset SINGLE_CONFIG ###
		dk_unset(SINGLE_CONFIG)
	
		### Unset CMAKE_BUILD_TYPE ###
		dk_unset(CMAKE_BUILD_TYPE)
		if(CMAKE_BUILD_TYPE)
			dk_error("multi-config generators don't use CMAKE_BUILD_TYPE")
		endif()
		
		### Target_Config_Type ###
		dk_set(Target_Config_Type 	"MULTI_CONFIG")
		
		### MULTI_CONFIG ###
		dk_set(${Target_Config_Type} 1)
		dk_assertVar(MULTI_CONFIG)
		
		### Target_Config ###
		dk_validate(Target_Tuple	"dk_Target_Tuple()")
		dk_set(Target_Config 		${Target_Tuple})
		dk_assertVar(Target_Config)
		
		### CMAKE_GENERATOR ###
		dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
		dk_assertVar(CMAKE_GENERATOR)
		
		### CMAKE_GENERATOR ###
		#dk_assertVar(CMAKE_CONFIGURATION_TYPES)
		dk_debug("*** ${CMAKE_GENERATOR}: Generator is MULTI_CONFIG (${CMAKE_CONFIGURATION_TYPES}) ***")
		
	### SINGLE_CONFIG ###
	else()
		### Unset MULTI_CONFIG ###
		dk_unset(MULTI_CONFIG)
		
		### Unset CMAKE_CONFIGURATION_TYPES ###
		dk_unset(CMAKE_CONFIGURATION_TYPES)
		if(CMAKE_CONFIGURATION_TYPES)
			dk_error("single-config generators don't use CMAKE_CONFIGURATION_TYPES")
		endif()
		
		### Target_Config_Type ###
		dk_set(Target_Config_Type 	"SINGLE_CONFIG")
		
		### SINGLE_CONFIG ###
		dk_set(${Target_Config_Type} 1)
		dk_assertVar(SINGLE_CONFIG)
		
		### CMAKE_BUILD_TYPE / Target_Config ###
		dk_validate(Target_Tuple	"dk_Target_Tuple()")
		if(Debug)
			dk_set(CMAKE_BUILD_TYPE Debug)
			dk_set(Target_Config ${Target_Tuple}/${Debug_Dir})
		elseif(Release)
			dk_set(CMAKE_BUILD_TYPE Release)
			dk_set(Target_Config ${Target_Tuple}/${Release_Dir})
		endif()
		dk_assertVar(CMAKE_BUILD_TYPE)
		dk_assertVar(Target_Config)
		
		### CMAKE_GENERATOR ###
		dk_validate(CMAKE_GENERATOR "dk_CMAKE_GENERATOR()")
		dk_assertVar(CMAKE_GENERATOR)
		dk_debug("*** ${CMAKE_GENERATOR}: Generator is SINGLE_CONFIG (${CMAKE_BUILD_TYPE}) ***")
	endif()
	
	### CURRENT_PLUGIN_Config_Dir ###
	if(CURRENT_PLUGIN)
		dk_set(${CURRENT_PLUGIN}_Config_Dir "${${CURRENT_PLUGIN}}/${Target_Config}")
		dk_debug("${CURRENT_PLUGIN}_Config_Dir = ${${CURRENT_PLUGIN}_Config_Dir}")
	endif()

endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_Target_Config()
endfunction()
