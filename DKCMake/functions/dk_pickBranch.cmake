#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

dk_fatal("dk_pickBranch.cmake is discontinued")
##################################################################################
# dk_pickBranch()
#
#
function(dk_pickBranch)
	dk_debugFunc()

	dk_echo()
    dk_echo(" 1) main")
    dk_echo(" 2) CMAKE_ENV_VARS")
	dk_echo(" 3) Development")
    dk_echo(" 4) Clear Screen")
    dk_echo(" 5) Go Back")
    dk_echo(" 6) Reload")
	dk_echo(" 7) Exit")
    dk_echo()
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("0 TODO")
	elseif("${input}" EQUAL "1")
		dk_gitCheckout("main")
	elseif("${input}" EQUAL "2")
		dk_gitCheckout("CMAKE_ENV_VARS")
	elseif("${input}" EQUAL "3")
		dk_gitCheckout("Development")
	elseif("${input}" EQUAL "4")
		dk_clearScreen()
	elseif("${input}" EQUAL "5")
		dk_unset(ENV{UPDATE})
	elseif("${input}" EQUAL "6")
		dk_reload()
	elseif("${input}" EQUAL "7")
		dk_exit(0)
	else()
		dk_warning("invalid selection: '${input}'")
	endif()
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_pickBranch()
endfunction()