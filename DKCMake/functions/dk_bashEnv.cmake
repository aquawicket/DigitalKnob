#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_bashEnv(<args>)
#
#	<args>	- TODO
#
function(dk_bashEnv)
	dk_debugFunc()
	
	###### set WORKING DIRECTORY ######
	if(${CURRENT_PLUGIN})
		dk_verbose("dk_bashEnv() CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
		set(BASH_WORKING_DIR "${${CURRENT_PLUGIN}_CONFIG_DIR}")
		list(APPEND BASH_COMMANDS "cd ${BASH_WORKING_DIR}")
		dk_cd(${BASH_WORKING_DIR})
	else()
		dk_error("No working dirctory set. Use dk_cd() to set the working directory before running Bash commands.")
	endif()
	
	dk_getOption2		(NO_HALT 			REMOVE)
	dk_getOption2		(NOECHO				REMOVE)
	dk_getOptionValue2	(OUTPUT_VARIABLE 	REMOVE)
	
	set(EXTRA_ARGS "")
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		dk_info("\n${clr}${magenta} bash> ${ARGV}\n")
	endif()
	
	dk_validate(MSYS2 "include(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)")
	if(ANDROID)
		dk_assertVar(ANDROID_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${ANDROID_BASH_EXPORTS})
	elseif(win_x86_clang)
		dk_assertVar(CLANG32_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANG32_BASH_EXPORTS})
	elseif(win_x86_64_clang)
		dk_assertVar(CLANG64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANG64_BASH_EXPORTS})
	elseif(win_arm64_clang)
		dk_assertVar(CLANGARM64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANGARM64_BASH_EXPORTS})
	elseif(win_x86_mingw)
		dk_assertVar(MINGW32_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MINGW32_BASH_EXPORTS})
	elseif(win_x86_64_mingw)
		dk_assertVar(MINGW64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MINGW64_BASH_EXPORTS})
	elseif(win_x86_64_ucrt)
		dk_assertVar(UCRT64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${UCRT64_BASH_EXPORTS})
	else()
		dk_warning("dk_bashEnv(): No BASH_EXPORTS defined")
	endif()
	if(WIN_HOST)
		dk_assertVar(MSYS2_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MSYS2_BASH_EXPORTS})
	endif()
	dk_replaceAll("${ARGV}"  ";"  " "  ARGV)
	list(APPEND BASH_COMMANDS "${ARGV}")
	
	### BASH_COMMANDS Adjustments ###
	if(WIN_HOST)
	if(NOT ANDROID)
		dk_replaceAll("${BASH_COMMANDS}"  "C:/"  "/c/"  BASH_COMMANDS)
		dk_replaceAll("${BASH_COMMANDS}"  "${CMAKE_GENERATOR}"  "'${CMAKE_GENERATOR}'"  BASH_COMMANDS)
	endif()
	endif()
	
	### CALL BASH_EXE WITH BASH_COMMANDS ###
	dk_replaceAll("${BASH_COMMANDS}"  ";"  " && "  BASH_COMMANDS)
	
	dk_validate(BASH_EXE "include(${DKIMPORTS_DIR}/bash/DKMAKE.cmake)")
	dk_executeProcess(${BASH_EXE} "-v" "-c" "${BASH_COMMANDS}" ${EXTRA_ARGS} ${NO_HALT} NOECHO)

	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_bashEnv(printenv)
endfunction()
