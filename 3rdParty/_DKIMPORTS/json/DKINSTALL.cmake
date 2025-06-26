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


############ json ############
# https://github.com/nlohmann/json.git

dk_validate(Target_Config  "dk_Target_Config()")

### NOTES ###
# This is a header only library, the compileable stuff below is unit testing
# include "json.hpp" to use this library 

### IMPORT ###
dk_import(https://github.com/nlohmann/json/archive/63258397.zip)

### LINK ###
dk_include(${JSON}/include/nlohmann)

#dk_set(JSON_TESTS ON)
if(JSON_TESTS)
	### GENERATE ###
	dk_configure()

	### COMPILE ###
	dk_build(${JSON} json_unit)
endif()
