#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_MSYSTEM()
#
#
function(dk_MSYSTEM)
	dk_debugFunc()

	### Set MSYSTEM
	dk_validate(target_env "dk_Target_Tuple()")
	
	if(Windows AND ${target_env})
		if(CLANG AND ARM64)
			dk_set(msystem "${target_env}${Target_Arch}")	# msystem = clangarm64
			dk_set(MSYSTEM "${TARGET_ENV}${Target_Arch}")	# MSYSTEM = CLANGARM64
		elseif(X86_64)
			dk_set(msystem "${target_env}64")				# msystem = clang64, mingw64, ucrt64
			dk_set(MSYSTEM "${TARGET_ENV}64")				# MSYSTEM = CLANG64, MINGW64, UCRT64
		elseif(X86)
			dk_set(msystem "${target_env}32")				# msystem = clang32, mingw32
			dk_set(MSYSTEM "${TARGET_ENV}32")				# MSYSTEM = CLANG32, MINGW32
		else()
			dk_warning("The Target_Tuple:${Target_Tuple} does not contain a valid msystem")
		endif()
		if(MSYSTEM)
			dk_set(${MSYSTEM} 1)							# CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
		endif()
	endif()
	
	dk_printVar(MSYSTEM)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_MSYSTEM()
endfunction()
