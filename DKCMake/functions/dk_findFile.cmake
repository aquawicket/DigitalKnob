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
# dk_findFile(file search_path rtn_var:optional)
#
#	Search for a file. The search order is.
#	0. Search 'search_path" if provided
#   1. Search local path
# 	2. Search local path with PATHEXT
#   3. Search PATH directories
#	4. Search PATH directories with PATHEXT
#	5. Search USERPROFILE
#	6. Search SystemRoot 
#
function(dk_findFile)
	#dk_debugFunc()
	
	#set(_file_ "${ARGV0}")

	execute_process(COMMAND cmd /c dir /b/s/a:-d "X:\\${ARGV0}" OUTPUT_VARIABLE dk_exec_stdout OUTPUT_STRIP_TRAILING_WHITESPACE)
	#dk_exec(cmd /c dir /b/s/a:-d "X:\\${ARGV0}")
	string(REGEX REPLACE "\n" ";" dk_exec_list "${dk_exec_stdout}")
	list(GET dk_exec_list 0 dk_findFile)
	dk_set(${ARGV0} "${dk_findFile}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_findFile(cmd.exe)
	dk_debug("cmd.exe = '${cmd.exe}'")
	
endfunction()