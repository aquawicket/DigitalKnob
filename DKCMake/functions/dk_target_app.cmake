#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_target_app()
#
#
function(dk_target_app)
	dk_debugFunc()

	dk_validate(target_triple "dk_target_triple()")
	dk_validate(target_type "dk_target_type()")

	dk_echo()
	dk_echo("${target_app} ${target_triple} ${target_type}")
	
	dk_echo()
    dk_echo(" 1) HelloWorld")
    dk_echo(" 2) DKCore")
    dk_echo(" 3) DKJavascript")
    dk_echo(" 4) DKSDL")
    dk_echo(" 5) DKSDLRml")
    dk_echo(" 6) DKDomTest")
    dk_echo(" 7) DKTestAll")
    dk_echo(" 8) Enter Manually")
    dk_echo(" 9) Clear Screen")
    dk_echo("10) Go Back")
    dk_echo("11) Reload")
	dk_echo("12) Exit")
    dk_echo()
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("repeating last selection")
		dk_set(target_app ${_target_app_})
		dk_set(target_triple ${_target_triple_})
		dk_set(target_type ${_target_type_})
		dk_set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_set(target_app "HelloWorld")
	elseif("${input}" EQUAL "2")
		dk_set(target_app "DKCore")
	elseif("${input}" EQUAL "3")
		dk_set(target_app "DKJavascript")
	elseif("${input}" EQUAL "4")
		dk_set(target_app "DKSDL")
	elseif("${input}" EQUAL "5")
		dk_set(target_app "DKSDLRml")
	elseif("${input}" EQUAL "6")
		dk_set(target_app "DKDomTest")
	elseif("${input}" EQUAL "7")
		dk_set(target_app "DKTestAll")
	elseif("${input}" EQUAL "8")
		dk_todo("dk _enterManually()")
	elseif("${input}" EQUAL "9")
		dk_clearScreen()
	elseif("${input}" EQUAL "10")
		dk_unset(ENV{UPDATE})
	elseif("${input}" EQUAL "11")
		dk_reload()
	elseif("${input}" EQUAL "12")
		dk_exit(0)
	else()
		dk_warning("invalid selection: '${input}'")
	endif()
	
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_target_app()
endfunction()