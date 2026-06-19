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
# dk_gitDiffSummary()
#
#
function(dk_gitDiffSummary)
	dk_debugFunc(0)
  
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
    
	dk_validate(git "dk_depend(git)")
	dk_chdir(${DKBRANCH_DIR})
	
	# git --no-pager diff --compact-summary
	dk_exec("${git_exe}" --no-pager diff --compact-summary)
    #execute_process(COMMAND "${git_exe}" --no-pager diff --compact-summary WORKING_DIRECTORY ${PWD})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitDiffSummary()
endfunction()
