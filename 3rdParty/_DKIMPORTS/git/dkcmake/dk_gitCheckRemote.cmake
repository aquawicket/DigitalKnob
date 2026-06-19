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
# dk_gitCheckRemote()
#
#
function(dk_gitCheckRemote)
	dk_debugFunc(0)
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	if(EXISTS "${DKBRANCH_DIR}/.git")
		
		dk_validate(git "dk_depend(git)")

		### git remote update
		dk_exec("${git_exe}" -C ${DKBRANCH_DIR} remote update)
		
		### branch = git rev-parse --abbrev-ref HEAD
		dk_exec("${git_exe}" -C ${DKBRANCH_DIR} rev-parse --abbrev-ref HEAD)
		set(branch ${dk_exec})
		
		### ahead = git rev-list --count origin/${branch}..${branch}
		dk_exec("${git_exe}" -C ${DKBRANCH_DIR} rev-list --count origin/${branch}..${branch})
		set(ahead ${dk_exec})

		### behind = git rev-list --count ${branch}..origin/${branch}
		dk_exec("${git_exe}" -C ${DKBRANCH_DIR} rev-list --count ${branch}..origin/${branch})
		set(behind ${dk_exec})
		
		dk_info("${branch} is ${ahead} commits ahead, ${behind} commits behind")
		dk_set(behind ${behind})
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc()
	
	dk_gitCheckRemote()
endfunction()