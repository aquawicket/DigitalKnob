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

##############################################################################
# dk_setXcodeProperty(TARGET property value)
# 
#	Set a XCode specific property
#
#   @TARGET		- The project target name to set the property for
#	@property	- The name of the property to set
#   @value		- The value to set the property to
#
function(dk_setXcodeProperty TARGET property value)
	dk_debugFunc()
	
    set_property(TARGET ${TARGET} PROPERTY XCODE_ATTRIBUTE_${property} ${value})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()