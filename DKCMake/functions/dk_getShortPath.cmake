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
# dk_getShortPath(path rtn_var)
#
#	TODO
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_getShortPath path)
	dk_debugFunc()
	
	#set(path "${ARGV0}")
	
	if(Windows_Host)
		dk_fileWrite(${DKCMAKE_DIR}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE_DIR}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE dk_getShortPath WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_replaceAll(${dk_getShortPath} "\\" "/" dk_getShortPath)
		dk_replaceAll(${dk_getShortPath} "\n" "" dk_getShortPath)
		
		###### return ######
		set(dk_getShortPath "${dk_getShortPath}" PARENT_SCOPE)
		if(ARGV1)
			set(${ARGV1} "${dk_getShortPath}" PARENT_SCOPE)
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getShortPath("C:/Program Files (x86)")
	dk_debug("dk_getShortPath = ${dk_getShortPath}")
endfunction()