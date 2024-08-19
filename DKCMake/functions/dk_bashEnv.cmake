include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_bashEnv(<args>)
#
#	<args>	- TODO
#
function(dk_bashEnv)
	dk_debugFunc(${ARGV})
	
	dk_getOption(NO_HALT ${ARGV} REMOVE)
	dk_getOption(NOECHO ${ARGV} REMOVE)
	dk_getOptionValue(OUTPUT_VARIABLE ${ARGV} REMOVE)
	
	set(EXTRA_ARGS "")
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		dk_info("\n${clr}${magenta} bash> ${ARGV}\n")
	endif()
	
	### BASH_EXE ###
	if(NOT EXISTS ${BASH_EXE})
		if(WIN_HOST)
			if(NOT EXISTS ${MSYS2}/msys2.exe)
				dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
			endif()
			set(BASH_EXE ${MSYS2}/usr/bin/bash)
		else()
			set(BASH_EXE bash)
		endif()
	endif()
	
	### BASH_COMMANDS ###
	list(APPEND BASH_COMMANDS "cd ${PWD}")
	if(ANDROID)
		dk_assert(ANDROID_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${ANDROID_BASH_EXPORTS})
	elseif("${DK_TARGET_TRIPLE}" STREQUAL "win_x86_clang")
		dk_assert(CLANG32_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANG32_BASH_EXPORTS})
	elseif(win_x86_64_clang)	
		dk_assert(CLANG64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANG64_BASH_EXPORTS})
	elseif(win_arm64_clang)
		dk_assert(CLANGARM64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANGARM64_BASH_EXPORTS})
	elseif(win_x86_mingw)
		dk_assert(MINGW32_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MINGW32_BASH_EXPORTS})
	elseif(win_x86_64_mingw)
		dk_assert(MINGW64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MINGW64_BASH_EXPORTS})
	elseif(win_x86_64_ucrt)
		dk_assert(UCRT64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${UCRT64_BASH_EXPORTS})
	else()
		dk_warning("dk_bashEnv(): NOT ANDROID, CLANG32, CLANG64, CLANGARM64, MINGW32, MINGW64 or UCRT64")
	endif()
	if(WIN_HOST)
		dk_assert(MSYS2_BASH_EXPORTS)
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
	dk_replaceAll("${BASH_COMMANDS}"  ";"  " & "  BASH_COMMANDS)
	#dk_replaceAll("${BASH_COMMANDS}"  ";"  "\n"  BASH_COMMANDS)
	dk_executeProcess(${BASH_EXE} "-v" "-c" "${BASH_COMMANDS}" ${EXTRA_ARGS} ${NO_HALT} NOECHO)


	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()

endfunction()
dk_createOsMacros("dk_bashEnv")







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()