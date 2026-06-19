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
# dk_gitCreateBranch()
#
#
function(dk_gitCreateBranch)
	dk_debugFunc(1)
	
	set(branch ${ARGV0})
	
	dk_validate(git "dk_depend(git)")
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	dk_exec("${git_exe}" -C ${DKBRANCH_DIR} checkout -b ${branch} main)
	dk_exec("${git_exe}" -C ${DKBRANCH_DIR} push --set-upstream origin ${branch})
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitCreateBranch("new_branch")
endfunction()