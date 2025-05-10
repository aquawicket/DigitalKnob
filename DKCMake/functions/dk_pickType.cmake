#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

dk_fatal("dk_pickType.cmake is discontinued")
##################################################################################
# dk_pickType()
#
#
function(dk_pickType)
	dk_debugFunc()

	dk_echo()
	dk_echo("${Target_App} ${Target_Triple} ${Target_Type}")
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
		dk_set(target_app ${_target_app_})
		dk_set(target_triple ${_target_triple_})
		dk_set(Target_Type ${_target_type_})
		dk_set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_set(Target_Type "Debug")
	elseif("${input}" EQUAL "1")
		dk_set(Target_Type "Release")
	elseif("${input}" EQUAL "1")
		dk_set(Target_Type "All")
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
	dk_debugFunc(0)
	
	dk_pickType()
endfunction()
