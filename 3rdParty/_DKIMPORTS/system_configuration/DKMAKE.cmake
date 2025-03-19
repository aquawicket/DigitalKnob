#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ system_configuration ############
# https://developer.apple.com/documentation/systemconfiguration?language=objc

dk_load(dk_builder)

if(NOT APPLE)
	dk_undepend(system_configuration)
	dk_return()
endif()

dk_findLibrary(SystemConfiguration)
