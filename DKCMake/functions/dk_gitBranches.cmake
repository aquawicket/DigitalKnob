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
# dk_gitBranches()
#
#
function(dk_gitBranches)
	dk_debugFunc(1)
	
	set(branch ${ARGV0})
	
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
	dk_validate(GIT_EXE "dk_installGit()")              
	execute_process(COMMAND "${GIT_EXE}" branch WORKING_DIRECTORY $ENV{DKBRANCH_DIR} OUTPUT_VARIABLE output OUTPUT_STRIP_TRAILING_WHITESPACE)
	string(REPLACE "\n" ";" branch_list ${output})
	
	# Iterate over the list and trim each element
	foreach(item IN LISTS branch_list)
		string(REPLACE "*" "" item ${item})
		string(STRIP "${item}" trimmed_item)
		list(APPEND TRIMMED_LIST "${trimmed_item}")
	endforeach()

	set(${ARGV0} "${TRIMMED_LIST}" PARENT_SCOPE)
	
	#dk_printVar(branch_list)
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitBranches(branches)
	dk_printVar(branches)
endfunction()