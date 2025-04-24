#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ json ############
# https://github.com/nlohmann/json.git

dk_load(dk_builder)

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
	dk_configure(${JSON_DIR})

	### COMPILE ###
	dk_build(${JSON} json_unit)
endif()
