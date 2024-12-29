#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

dk_fatal("dk_pickApp.cmake is discontinued")
##################################################################################
# dk_pickApp()
#
#
function(dk_pickApp)
	dk_debugFunc()

	dk_echo()
	dk_echo("${APP} ${target_triple} ${DKBUILD_TYPE}")
	
	dk_echo()
    dk_echo(" 1) HelloWorld")
	dk_echo(" 2) DKPreprocessor")
    dk_echo(" 3) DKCore")
    dk_echo(" 4) DKJavascript")
    dk_echo(" 5) DKSDL")
    dk_echo(" 6) DKSDLRml")
    dk_echo(" 7) DKDomTest")
    dk_echo(" 8) DKTestAll")
    dk_echo(" 9) Enter Manually")
    dk_echo("10) Clear Screen")
    dk_echo("11) Go Back")
    dk_echo("12) Reload")
	dk_echo("13) Exit")
    dk_echo()
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("repeating last selection")
		dk_set(APP ${_APP_})
		dk_set(target_triple ${_target_triple_})
		dk_set(DKBUILD_TYPE ${_BUILD_TYPE_})
		dk_set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_set(APP "HelloWorld")
	elseif("${input}" EQUAL "2")
		dk_set(APP "DKPreprocessor")
	elseif("${input}" EQUAL "3")
		dk_set(APP "DKCore")
	elseif("${input}" EQUAL "4")
		dk_set(APP "DKJavascript")
	elseif("${input}" EQUAL "5")
		dk_set(APP "DKSDL")
	elseif("${input}" EQUAL "6")
		dk_set(APP "DKSDLRml")
	elseif("${input}" EQUAL "7")
		dk_set(APP "DKDomTest")
	elseif("${input}" EQUAL "8")
		dk_set(APP "DKTestAll")
	elseif("${input}" EQUAL "9")
		dk_todo("dk _enterManually()")
	elseif("${input}" EQUAL "10")
		dk_clearScreen()
	elseif("${input}" EQUAL "11")
		dk_unset(ENV{UPDATE})
	elseif("${input}" EQUAL "12")
		dk_reload()
	elseif("${input}" EQUAL "13")
		dk_exit(0)
	else()
		dk_warning("invalid selection: '${input}'")
	endif()
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_pickApp()
endfunction()