#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_gitDeleteBranch()
#
#   reference: https://stackoverflow.com/a/2003515/688352
#
function(dk_gitDeleteBranch)
	dk_debugFunc(1)
	
	set(branch ${ARGV0})
	
	dk_validate(git_exe "dk_depend(git)")
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")            
	dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} push -d origin ${branch})	# Delete remote branch
	dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} branch -d ${branch})			# Delete local branch
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitDeleteBranch("new_branch")
endfunction()