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


############ json ############
# https://github.com/nlohmann/json.git
# https://github.com/nlohmann/json/archive/63258397.zip

### NOTES ###
# This is a header only library, the compileable stuff below is unit testing
# include "json.hpp" to use this library 

### IMPORT ###
dk_import()

### LINK ###
dk_include(${json}/include/nlohmann)

#dk_set(json_TESTS ON)
if(json_TESTS)
	dk_configure()

	dk_build(${json} json_unit)
endif()
