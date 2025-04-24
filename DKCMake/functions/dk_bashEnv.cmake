#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_bashEnv(<args>)
#
#	<args>	- TODO
#
function(dk_bashEnv)
	dk_debugFunc()
	
<<<<<<< HEAD
	###### set WORKING DIRECTORY ######
	if(${CURRENT_PLUGIN})
		dk_verbose("dk_bashEnv() CURRENT_PLUGIN = ${CURRENT_PLUGIN}")
		set(BASH_WORKING_DIR "${${CURRENT_PLUGIN}_CONFIG_DIR}")
		list(APPEND BASH_COMMANDS "cd ${BASH_WORKING_DIR}")
		dk_cd(${BASH_WORKING_DIR})
	else()
		dk_error("No working dirctory set. Use dk_cd() to set the working directory before running Bash commands.")
	endif()
	
	dk_getOption		(NO_HALT 			${ARGV} REMOVE)
	dk_getOption		(NOECHO 			${ARGV} REMOVE)
	dk_getOptionValue	(OUTPUT_VARIABLE 	${ARGV} REMOVE)
=======
	dk_notice("#################################################################################################################################")
	dk_notice("dk_bashEnv SHOULD NOT BE USED!  take a look at how /_DKIMPORTS/openssl/DKINSTALL.cmake runs configure for win_x86_64_clang from cmd.")
	dk_notice("#################################################################################################################################")
	dk_pause()
	return()
	
	###### set WORKING DIRECTORY ######
	if($ENV{CURRENT_PLUGIN})
		dk_verbose("dk_bashEnv() CURRENT_PLUGIN = $ENV{CURRENT_PLUGIN}")
		set(BASH_WORKING_DIR "${$ENV{CURRENT_PLUGIN}_CONFIG_DIR}")
		list(APPEND BASH_COMMANDS "cd ${BASH_WORKING_DIR}")
		dk_chdir(${BASH_WORKING_DIR})
	else()
		dk_error("No working dirctory set. Use dk_chdir() to set the working directory before running Bash commands.")
	endif()
	
	dk_getOption		(NO_HALT 			REMOVE)
	dk_getOption		(NOECHO				REMOVE)
	dk_getOptionValue	(OUTPUT_VARIABLE 	REMOVE)
>>>>>>> Development
	
	set(EXTRA_ARGS "")
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		dk_info("\n${clr}${magenta} bash> ${ARGV}\n")
	endif()
	
<<<<<<< HEAD
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
=======
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_depend(cygpath)
	dk_command(${CYGPATH_EXE} -m "${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_CYGPATH)
	
	if(ANDROID)
		dk_assertVar(ANDROID_BASH)
		list(APPEND BASH_COMMANDS ${ANDROID_BASH})
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
	elseif(win_x86_gcc)
		dk_set(MINGW32_BIN	"export PATH=${MSYS2_CYGPATH}/mingw32/bin:$PATH")
		dk_assertVar(MINGW32_BIN)
		list(APPEND BASH_COMMANDS ${MINGW32_BIN})
	elseif(win_x86_64_gcc)
		dk_set(MINGW64_BIN	"export PATH=${MSYS2_CYGPATH}/mingw64/bin:$PATH")
		dk_assertVar(MINGW64_BIN)
		list(APPEND BASH_COMMANDS ${MINGW64_BIN})
	elseif(win_x86_64_ucrt)
		dk_set(UCRT64_BIN "export PATH=${MSYS2_CYGPATH}/ucrt64/bin:$PATH")
		dk_assertVar(UCRT64_BIN)
		list(APPEND BASH_COMMANDS ${UCRT64_BIN})
>>>>>>> Development
	else()
		dk_warning("dk_bashEnv(): No BASH_EXPORTS defined")
	endif()
	if(WIN_HOST)
<<<<<<< HEAD
		dk_assertVar(MSYS2_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MSYS2_BASH_EXPORTS})
=======
		dk_set(MSYS2_BIN "export PATH=${MSYS2_CYGPATH}/usr/bin:$PATH")
		dk_assertVar(MSYS2_BIN)
		list(APPEND BASH_COMMANDS ${MSYS2_BIN})
>>>>>>> Development
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
	
<<<<<<< HEAD
	dk_validate(BASH_EXE "include(${DKIMPORTS_DIR}/bash/DKMAKE.cmake)")
	dk_executeProcess(${BASH_EXE} "-v" "-c" "${BASH_COMMANDS}" ${EXTRA_ARGS} ${NO_HALT} NOECHO)
=======
	dk_depend(bash)
	dk_exec(${BASH_EXE} "-v" "-c" "${BASH_COMMANDS}" ${EXTRA_ARGS} ${NO_HALT} NOECHO)
>>>>>>> Development

	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_bashEnv(printenv)
endfunction()
