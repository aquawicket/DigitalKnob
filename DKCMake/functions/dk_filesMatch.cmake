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

###############################################################################
# dk_filesMatch(fileA fileB)
#
#	TODO
#
#	@fileA	- TODO
#	@fileB	- TODO
#
function(dk_filesMatch fileA fileB)
	dk_debugFunc()
	
	execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${fileA} ${fileB} RESULT_VARIABLE compare_result)
	if(compare_result EQUAL 0)
		dk_info("The files are identical.")
	elseif(compare_result EQUAL 1)
		dk_info("The files are different.")
	else()
		dk_info("Error while comparing the files.")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
