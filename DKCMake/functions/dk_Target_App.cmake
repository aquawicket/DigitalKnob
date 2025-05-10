#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_Target_App()
#
#
function(dk_Target_App)
	dk_debugFunc()

	dk_validate(Target_Triple "dk_Target_Triple()")
	dk_validate(Target_Type "dk_Target_Type()")

	dk_echo()
	dk_echo("${Target_App} ${Target_Triple} ${Target_Type}")
	
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
		dk_set(Target_App ${_Target_App_})
		dk_set(Target_Triple ${_Target_Triple_})
		dk_set(Target_Type ${_Target_Type_})
		dk_set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_set(Target_App "HelloWorld")
	elseif("${input}" EQUAL "2")
		dk_set(Target_App "DKCore")
	elseif("${input}" EQUAL "3")
		dk_set(Target_App "DKJavascript")
	elseif("${input}" EQUAL "4")
		dk_set(Target_App "DKSDL")
	elseif("${input}" EQUAL "5")
		dk_set(Target_App "DKSDLRml")
	elseif("${input}" EQUAL "6")
		dk_set(Target_App "DKDomTest")
	elseif("${input}" EQUAL "7")
		dk_set(Target_App "DKTestAll")
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
	
	dk_Target_App()
endfunction()