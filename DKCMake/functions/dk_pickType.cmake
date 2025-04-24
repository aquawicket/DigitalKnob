#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

dk_fatal("dk_pickType.cmake is discontinued")
>>>>>>> Development
##################################################################################
# dk_pickType()
#
#
function(dk_pickType)
	dk_debugFunc()

	dk_echo()
<<<<<<< HEAD
	dk_echo("${APP} ${target_triple} ${TYPE}")
=======
	dk_echo("${target_app} ${target_triple} ${target_type}")
>>>>>>> Development
	dk_echo()
    dk_echo(" 1) Debug")
	dk_echo(" 2) Release")
	dk_echo(" 3) All")
	dk_echo(" 4) Clear Screen")
	dk_echo(" 5) Go Back")
	dk_echo(" 6) Exit")
	dk_echo()
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("repeating last selection")
<<<<<<< HEAD
		dk_set(APP ${_APP_})
		dk_set(target_triple ${_target_triple_})
		dk_set(TYPE ${_TYPE_})
		dk_set(UPDATE 1)
	elseif("${input}" EQUAL "1")
		dk_set(TYPE "Debug")
	elseif("${input}" EQUAL "1")
		dk_set(TYPE "Release")
	elseif("${input}" EQUAL "1")
		dk_set(TYPE "All")
=======
		dk_set(target_app ${_target_app_})
		dk_set(target_triple ${_target_triple_})
		dk_set(target_type ${_target_type_})
		dk_set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_set(target_type "Debug")
	elseif("${input}" EQUAL "1")
		dk_set(target_type "Release")
	elseif("${input}" EQUAL "1")
		dk_set(target_type "All")
>>>>>>> Development
	elseif("${input}" EQUAL "1")
		dk_clearScreen()
	elseif("${input}" EQUAL "1")
		dk_unset(target_triple)
	elseif("${input}" EQUAL "1")
		dk_exit(0)
	else()
		dk_warning("invalid selection")
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_pickType()
endfunction()
