#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_pickType()
#
#
function(dk_pickType)
	dk_debugFunc("\${ARGV}")

	dk_echo()
	dk_echo("${APP} ${target_triple} ${TYPE-}")
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
	dk_debugFunc("\${ARGV}")
	
	dk_pickType()
endfunction()