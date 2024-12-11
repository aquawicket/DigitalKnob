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
	
	dk_notice("#################################################################################################################################")
	dk_notice("dk_bashEnv SHOULD NOT BE USED!  take a look at how /_DKIMPORTS/openssl/DKMAKE.cmake runs configure for win_x86_64_clang from cmd.")
	dk_notice("#################################################################################################################################")
	dk_pause()
	return()
	
	###### set WORKING DIRECTORY ######
	if(${CURRENT_PLUGIN})
		dk_verbose("dk_bashEnv() CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
		set(BASH_WORKING_DIR "${${CURRENT_PLUGIN}_CONFIG_DIR}")
		list(APPEND BASH_COMMANDS "cd ${BASH_WORKING_DIR}")
		dk_cd(${BASH_WORKING_DIR})
	else()
		dk_error("No working dirctory set. Use dk_cd() to set the working directory before running Bash commands.")
	endif()
	
	dk_getOption		(NO_HALT 			REMOVE)
	dk_getOption		(NOECHO				REMOVE)
	dk_getOptionValue	(OUTPUT_VARIABLE 	REMOVE)
	
	set(EXTRA_ARGS "")
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		dk_info("\n${clr}${magenta} bash> ${ARGV}\n")
	endif()
	
	dk_depend(msys2)
	dk_depend(cygpath)
	dk_command(${CYGPATH_EXE} -m "${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_CYGPATH)
	
	if(ANDROID)
		dk_assertVar(ANDROID_BIN)
		list(APPEND BASH_COMMANDS ${ANDROID_BIN})
	elseif(win_x86_clang)
		dk_set(CLANG32_BIN	"export PATH=${MSYS2_CYGPATH}/clang32/bin:$PATH")
		dk_assertVar(CLANG32_BIN)
		list(APPEND BASH_COMMANDS ${CLANG32_BIN})
	elseif(win_x86_64_clang)
		set(CLANG64_BIN "export PATH=${MSYS2_CYGPATH}/clang64/bin:$PATH")
		dk_assertVar(CLANG64_BIN)
		list(APPEND BASH_COMMANDS ${CLANG64_BIN})
	elseif(win_arm64_clang)
		dk_set(CLANGARM64_BIN "export PATH=${MSYS2_CYGPATH}/clangarm64/bin:$PATH")
		dk_assertVar(CLANGARM64_BIN)
		list(APPEND BASH_COMMANDS ${CLANGARM64_BIN})
	elseif(win_x86_mingw)
		dk_set(MINGW32_BIN	"export PATH=${MSYS2_CYGPATH}/mingw32/bin:$PATH")
		dk_assertVar(MINGW32_BIN)
		list(APPEND BASH_COMMANDS ${MINGW32_BIN})
	elseif(win_x86_64_mingw)
		dk_set(MINGW64_BIN	"export PATH=${MSYS2_CYGPATH}/mingw64/bin:$PATH")
		dk_assertVar(MINGW64_BIN)
		list(APPEND BASH_COMMANDS ${MINGW64_BIN})
	elseif(win_x86_64_ucrt)
		dk_set(UCRT64_BIN "export PATH=${MSYS2_CYGPATH}/ucrt64/bin:$PATH")
		dk_assertVar(UCRT64_BIN)
		list(APPEND BASH_COMMANDS ${UCRT64_BIN})
	else()
		dk_warning("dk_bashEnv(): No BASH_EXPORTS defined")
	endif()
	if(WIN_HOST)
		dk_set(MSYS2_BIN "export PATH=${MSYS2_CYGPATH}/usr/bin:$PATH")
		dk_assertVar(MSYS2_BIN)
		list(APPEND BASH_COMMANDS ${MSYS2_BIN})
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
	
	dk_depend(bash)
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
