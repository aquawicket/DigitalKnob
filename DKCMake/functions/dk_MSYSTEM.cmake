#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_MSYSTEM()
#
#
function(dk_MSYSTEM)
	dk_debugFunc()

	### Set MSYSTEM
	dk_validate(target_env "dk_Target_Env()")
	
	if(Windows AND Target_Env)
		if(CLANG AND ARM64)
			dk_set(MSYSTEM "${Target_Env}${Target_Arch}")	# MSYSTEM = CLANGARM64
		elseif(X86_64)
			dk_set(MSYSTEM "${Target_Env}64")				# MSYSTEM = CLANG64, MINGW64, UCRT64
		elseif(X86)
			dk_set(MSYSTEM "${Target_Env}32")				# MSYSTEM = CLANG32, MINGW32
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
