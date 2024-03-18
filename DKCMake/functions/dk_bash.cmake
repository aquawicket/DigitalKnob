include_guard()

###############################################################################
# dk_bash(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_bash)
	DKDEBUGFUNC(${ARGV})
	
	dk_get_option(NOASSERT ${ARGV})
	dk_get_option(NOECHO ${ARGV})
	dk_get_option_value(OUTPUT_VARIABLE ${ARGV})
	
	string(REPLACE ";" " "	ARGV "${ARGV}")
	dk_info("\n${CLR}${magenta} bash> ${ARGV}\n")
	
	### BASH_EXE ###
	if(NOT BASH_EXE)
		if(WIN_HOST)
			if(NOT MSYS2)
				dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
			endif()
			set(BASH_EXE ${MSYS2}/usr/bin/bash)
		else()
			set(BASH_EXE bash)
		endif()
	endif()
	
	### BASH_COMMANDS ###
	list(APPEND BASH_COMMANDS "cd ${CURRENT_DIR}")
	if(ANDROID)
		DK_ASSERT(ANDROID_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${ANDROID_BASH_EXPORTS})
	elseif(CLANG32)
		DK_ASSERT(CLANG32_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANG32_BASH_EXPORTS})
	elseif(CLANG64)
		DK_ASSERT(CLANG64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANG64_BASH_EXPORTS})
	elseif(CLANGARM64)
		DK_ASSERT(CLANGARM64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${CLANGARM64_BASH_EXPORTS})
	elseif(MINGW32)
		DK_ASSERT(MINGW32_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MINGW32_BASH_EXPORTS})
	elseif(MINGW64)
		DK_ASSERT(MINGW64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MINGW64_BASH_EXPORTS})
	elseif(UCRT64)
		DK_ASSERT(UCRT64_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${UCRT64_BASH_EXPORTS})
	else()
		dk_error("dk_bash(): NOT ANDROID, CLANG32, CLANG64, CLANGARM64, MINGW32, MINGW64 or UCRT64")
	endif()
	if(WIN_HOST)
		DK_ASSERT(MSYS2_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MSYS2_BASH_EXPORTS})
	endif()
	list(APPEND BASH_COMMANDS ${ARGV})
	
	### BASH_COMMANDS Adjustments ###
	if(WIN_HOST)
		string(REPLACE "${CMAKE_GENERATOR}" "'${CMAKE_GENERATOR}'" BASH_COMMANDS "${BASH_COMMANDS}")
		string(REPLACE "C:/" "/c/" BASH_COMMANDS "${BASH_COMMANDS}")
	endif()
	
	### CALL BASH_EXE WITH BASH_COMMANDS ###
	dk_debug("execute_process(COMMAND ${BASH_EXE} -c '${BASH_COMMANDS}'")
	execute_process(COMMAND ${BASH_EXE} -c "${BASH_COMMANDS}"
		RESULT_VARIABLE result 
		ERROR_VARIABLE error 
		WORKING_DIRECTORY ${CURRENT_DIR} 
		OUTPUT_STRIP_TRAILING_WHITESPACE)
		
	if(NOT ${result} EQUAL 0)
		dk_debug(command	PRINTVAR)
		dk_debug(result		PRINTVAR)
		dk_debug(error		PRINTVAR)
	endif()
endfunction()
dk_createOsMacros("dk_bash")