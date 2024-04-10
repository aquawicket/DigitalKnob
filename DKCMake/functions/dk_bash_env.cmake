include_guard()

###############################################################################
# dk_bash_env(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_bash_env)
	DKDEBUGFUNC(${ARGV})
	
	dk_get_option(NOASSERT ${ARGV} REMOVE)
	dk_get_option(NOECHO ${ARGV} REMOVE)
	dk_get_option_value(OUTPUT_VARIABLE ${ARGV} REMOVE)
	
	set(EXTRA_ARGS "")
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		dk_info("\n${CLR}${magenta} bash> ${ARGV}\n")
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
		dk_warning("dk_bash_env(): NOT ANDROID, CLANG32, CLANG64, CLANGARM64, MINGW32, MINGW64 or UCRT64")
	endif()
	if(WIN_HOST)
		DK_ASSERT(MSYS2_BASH_EXPORTS)
		list(APPEND BASH_COMMANDS ${MSYS2_BASH_EXPORTS})
	endif()
	string(REPLACE ";" " "	ARGV "${ARGV}")
	list(APPEND BASH_COMMANDS "${ARGV}")
	
	### BASH_COMMANDS Adjustments ###
	if(WIN_HOST)
	if(NOT ANDROID)
		string(REPLACE "C:/" "/c/" BASH_COMMANDS "${BASH_COMMANDS}")
		string(REPLACE "${CMAKE_GENERATOR}" "'${CMAKE_GENERATOR}'" BASH_COMMANDS "${BASH_COMMANDS}")
	endif()
	endif()
	
	### CALL BASH_EXE WITH BASH_COMMANDS ###
	string(REPLACE ";" " & " BASH_COMMANDS "${BASH_COMMANDS}")
	#string(REPLACE ";" "\n" BASH_COMMANDS "${BASH_COMMANDS}")
	dk_executeProcess(${BASH_EXE} "-v" "-c" "${BASH_COMMANDS}" ${EXTRA_ARGS} ${NOASSERT} NOECHO)


	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()

endfunction()
dk_createOsMacros("dk_bash_env")