#/usr/bin/cmake -P
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
# dk_allButFirstArgs(args)
#
#
function(dk_allButFirstArgs arg1)
    dk_debugFunc(1 99)

	set(dk_allButFirstArgs ${ARGN} PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	DKTEST_B(one two three a b c)
endfunction()

function(DKTEST_B)
	dk_allButFirstArgs(${ARGV})
	message("dk_allButFirstArgs = ${dk_allButFirstArgs}")
endfunction()