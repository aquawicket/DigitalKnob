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
# dk_gitUpdate()
#
#
function(dk_gitUpdate)
	dk_debugFunc(2 3)

	set(url ${ARGV0}) 
	if(NOT url)
		set(url "https://github.com/aquawicket/DigitalKnob.git") 	#DEFAULT
	endif()
	
	set(branch ${ARGV1})
	if(NOT branch)
		set(branch "Development")									#DEFAULT
	endif()
	
	dk_validate(git_exe "dk_depend(git)")
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
	
	if(NOT EXISTS "$ENV{DKBRANCH_DIR}/.git")
		dk_exec("${git_exe}" clone ${url} "$ENV{DKBRANCH_DIR}")
	endif()
	
	dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} pull --all)
    dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} checkout -- .)
	
	dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} checkout ${branch})	
	if(NOT ${dk_exec_exitcode} EQUAL 0)
		dk_echo("Remote has no ${branch} branch. Creating...")
		dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} checkout -b ${branch} main)
		dk_exec("${git_exe}" -C $ENV{DKBRANCH_DIR} push --set-upstream origin ${branch})
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitUpdate()
endfunction()