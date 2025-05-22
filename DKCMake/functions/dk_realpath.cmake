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
# dk_realpath(path, rtn_var)
#
#    CMAKE: https://cmake.org/cmake/help/latest/command/get_filename_component.html
#
function(dk_realpath path rtn_var)
	dk_debugFunc(2)
	
	get_filename_component(_realpath_ ${path} REALPATH)
	#dk_printVar(_realpath_)
	set(${rtn_var} ${_realpath_} PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) #
	dk_debugFunc()
	
	dk_realpath("bash" realpath)
	dk_info("realpath = ${realpath}")
endfunction()