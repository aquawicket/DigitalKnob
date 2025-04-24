#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

#dk_fatal("dk_pickUpdate.cmake is discontinued")
>>>>>>> Development
##############################################################################
# dk_pickUpdate()
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pickUpdate) 
<<<<<<< HEAD
	dk_debugFunc()
	if(NOT ${ARGC} EQUAL 0)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	dk_readCache(_APP_ _target_triple_ _TYPE_)
	#dk_printVar(_APP_)
	#dk_printVar(_target_triple_) 
	#dk_printVar(_TYPE_)
	
	dk_echo()
	dk_gitCheckRemote()
	dk_echo()
	
	if(${behind} LESS 1)
		if(_APP_ AND _target_triple_ AND _TYPE_)
			dk_echo(" 0) Repeat cache [${_APP_} - ${_target_triple_} - ${_TYPE_}]")
=======
	dk_debugFunc(0)

	dk_gitCheckRemote()
	
	unset(target_app)
	unset(target_triple)
	unset(target_type)
	dk_readCache(target_app target_triple target_type)
	
	if(${behind} LESS 1)
		if((DEFINED target_app) AND (DEFINED target_triple) AND (DEFINED target_type))
			dk_echo(" 0) Repeat DKBuilder.cache $target_app - $target_triple - $target_type")
>>>>>>> Development
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
<<<<<<< HEAD
=======
		dk_validate(ENV{DKBRANCH_DIR} "dk_call dk_DKBRANCH_DIR()")
		if(EXISTS "$ENV{DKBRANCH_DIR}/build_list.txt")
			dk_echo("11) Run 'build_list.txt'")
		endif()
>>>>>>> Development
		dk_echo()
		dk_echo(" Press Enter To Skip")
	else()
		dk_warning("Your local repository is behind, please git update")
		dk_echo()
<<<<<<< HEAD
		dk_echo("${red}") 
		if(_APP_ AND  _target_triple_ AND _TYPE_)
			dk_echo(" 0) Repeat cache [${_APP_} - ${_target_triple_} - ${_TYPE_}]")
		endif()
		dk_echo("${green}")
		dk_echo(" 1) Git Update")
		dk_echo("${red}")
=======
		dk_echo("$ENV{red}") 
		if(DEFINED ENV{_target_app_} AND DEFINED ENV{_target_triple_} AND DEFINED ENV{_DKBUILD_TYPE_})
			dk_echo(" 0) Repeat DKBuilder.cache [$ENV{_target_app_} - $ENV{_target_triple_} - $ENV{_DKBUILD_TYPE_}]")
		endif()
		dk_echo("$ENV{green}")
		dk_echo(" 1) Git Update")
		dk_echo("$ENV{red}")
>>>>>>> Development
		dk_echo(" 2) Git Commit")
		dk_echo(" 3) Push assets")
		dk_echo(" 4) Pull assets")
		dk_echo(" 5) Reset All")
		dk_echo(" 6) Remove All")
		dk_echo(" 7) Clear Screen")
<<<<<<< HEAD
		dk_echo(" 8) Clear cmake cache and .tmp files")
		dk_echo(" 9) Reload")
		dk_echo("10) Exit")
		dk_echo()
		dk_echo("Press Enter To Skip")
		dk_echo("${clr}")
	endif()
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("repeating last selection")
		dk_set(APP ${_APP_})
		dk_set(target_triple ${_target_triple_})
		dk_set(TYPE ${_TYPE_})
		dk_set(UPDATE 1)
	elseif("${input}" EQUAL "1")
		dk_gitUpdate()
=======
		dk_echo(" 8) Reload")
		dk_echo(" 9) Exit")
		if("${choice}" STREQUAL "11")
			set(BUILD_LIST_FILE "$ENV{DKBRANCH_DIR}/build_list.txt")
			return()
		endif()
		dk_echo()
		dk_echo("Press Enter To Skip")
		dk_echo("$ENV{clr}")
	endif()
	
	
	dk_keyboardInput(input)
	if("${input}" EQUAL "0")
		dk_echo("repeating last selection")
		dk_set(target_app $ENV{_target_app_})
		dk_set(target_triple $ENV{_target_triple_})
		dk_set(target_type $ENV{_DKBUILD_TYPE_})
		set(ENV{UPDATE} 1)
	elseif("${input}" EQUAL "1")
		dk_gitUpdate("https://github.com/aquawicket/DigitalKnob.git" "Development")
>>>>>>> Development
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
<<<<<<< HEAD
		dk_clearCmakeCache()
		dk_deleteTempFiles()
	elseif("${input}" EQUAL "9")
		dk_reload()
	elseif("${input}" EQUAL "10")
		dk_exit(0)	
	elseif("${input}" STREQUAL "")
		dk_set(UPDATE 1)
=======
		dk_reload()
	elseif("${input}" EQUAL "9")
		dk_exit(0)	
	elseif("${input}" STREQUAL "")
		set(ENV{UPDATE} 1)
>>>>>>> Development
	else()
		dk_warning("invalid selection: '${input}'")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_pickUpdate()
endfunction()
