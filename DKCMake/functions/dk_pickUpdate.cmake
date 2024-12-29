#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

#dk_fatal("dk_pickUpdate.cmake is discontinued")
##############################################################################
# dk_pickUpdate()
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pickUpdate) 
	dk_debugFunc(0)


	dk_gitCheckRemote()

	
	unset(APP)
	unset(target_triple)
	unset(DKBUILD_TYPE)
	dk_readCache(APP target_triple DKBUILD_TYPE)
	
	if(${behind} LESS 1)
		if((DEFINED APP) AND (DEFINED target_triple) AND (DEFINED DKBUILD_TYPE))
			dk_echo(" 0) Repeat cache $APP - $target_triple - $DKBUILD_TYPE")
		endif()
		dk_echo(" 1) Git Update") 
		dk_echo(" 2) Git Commit")
		dk_echo(" 3) Push assets")
		dk_echo(" 4) Pull assets")
		dk_echo(" 5) Reset All")
		dk_echo(" 6) Remove All")
		dk_echo(" 7) Clear Screen")
		dk_echo(" 8) Clear cmake cache and .tmp files")
		dk_echo(" 9) Reload")
		dk_echo("10) Exit")
		dk_echo()
		dk_echo(" Press Enter To Skip")
	else()
		dk_warning("Your local repository is behind, please git update")
		dk_echo()
		dk_echo("$ENV{red}") 
		if(DEFINED ENV{_APP_} AND DEFINED ENV{_target_triple_} AND DEFINED ENV{_DKBUILD_TYPE_})
			dk_echo(" 0) Repeat cache [$ENV{_APP_} - $ENV{_target_triple_} - $ENV{_DKBUILD_TYPE_}]")
		endif()
		dk_echo("$ENV{green}")
		dk_echo(" 1) Git Update")
		dk_echo("$ENV{red}")
		dk_echo(" 2) Git Commit")
		dk_echo(" 3) Push assets")
		dk_echo(" 4) Pull assets")
		dk_echo(" 5) Reset All")
		dk_echo(" 6) Remove All")
		dk_echo(" 7) Clear Screen")
		dk_echo(" 8) Reload")
		dk_echo(" 9) Exit")
		dk_echo()
		dk_echo("Press Enter To Skip")
		dk_echo("$ENV{clr}")
	endif()
	
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("repeating last selection")
		dk_set(APP $ENV{_APP_})
		dk_set(target_triple $ENV{_target_triple_})
		dk_set(DKBUILD_TYPE $ENV{_DKBUILD_TYPE_})
		set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_gitUpdate("https://github.com/aquawicket/DigitalKnob.git" "Development")
	elseif("${input}" EQUAL "2")
		dk_gitCommit()
	elseif("${input}" EQUAL "3")
		dk_pushAssets()
	elseif("${input}" EQUAL "4")
		dk_pullAssets()
	elseif("${input}" EQUAL "5")
		dk_resetAll()
	elseif("${input}" EQUAL "6")
		dk_removeAll()
	elseif("${input}" EQUAL "7")
		dk_clearScreen()
	elseif("${input}" EQUAL "8")
		dk_reload()
	elseif("${input}" EQUAL "9")
		dk_exit(0)	
	elseif("${input}" STREQUAL "")
		set(ENV{UPDATE} 1)
	else()
		dk_warning("invalid selection: '${input}'")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_pickUpdate()
endfunction()
