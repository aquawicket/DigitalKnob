#!/usr/bin/cmake -P
message(FATAL_ERROR "dk_setDigitalknobPath() is obsolete")
return()
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
# dk_setDigitalknobPath()
#
#	Set the DigitalKnob root directory environment variable
#
function(dk_setDigitalknobPath)
	dk_debugFunc()
	
	# Set the DIGITALKNOB_DIR environment variable 
	dk_getFullPath(${CMAKE_SOURCE_DIR} path)
	string(FIND "${path}" "DigitalKnob" pos)
	string(SUBSTRING ${path} 0 ${pos} path)
	set(DIGITALKNOB_DIR ${path}DigitalKnob 						CACHE INTERNAL "" FORCE)
	set(DKCMAKE_DIR "${DIGITALKNOB_DIR}/Development/DKCMake/" 	CACHE INTERNAL "" FORCE)
	set(DIGITALKNOB_DIR "${DIGITALKNOB_DIR}"                    CACHE INTERNAL "" FORCE)
	set(DKCMAKE_DIR ${DKCMAKE_DIR} 								CACHE INTERNAL "" FORCE)
	if(Windows_Host)
		dk_validate(cmd.exe "dk_depend(cmd.exe)")
		execute_process(COMMAND ${cmd.exe} /c setx DIGITALKNOB_DIR ${DIGITALKNOB_DIR})
		execute_process(COMMAND ${cmd.exe} /c setx DKCMAKE_DIR ${DKCMAKE_DIR})
	endif()
	#dk_printVar(DIGITALKNOB_DIR)
	#dk_printVar(DKCMAKE_DIR)
	#dk_printVar(DIGITALKNOB_DIR)
	#dk_printVar(DKCMAKE_DIR)
endfunction()
dk_setDigitalknobPath()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
