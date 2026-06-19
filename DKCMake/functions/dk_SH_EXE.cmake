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

####################################################################
# dk_sh_exe()
#
#
function(dk_sh_exe)
	dk_debugFunc()

	if(EXISTS "${sh_exe}")
		dk_debug("sh_exe:${sh_exe} already set")
		return()
	endif()

	### from sh_exe environment variable ###
	if(NOT EXISTS "${sh_exe}")
		dk_set(sh_exe "$ENV{sh_exe}")
	endif()
	
	### from SH environment variable ###
	if(NOT EXISTS "${sh_exe}")
		dk_set(sh_exe "$ENV{SH}")
	endif()

	### from Msys2 bash ###
	if(NOT EXISTS "${sh_exe}")
		dk_validate(msys2 "dk_depend(msys2)")
		dk_findProgram(MSYS2_sh_exe sh "${msys2}/usr/bin")
		dk_set(sh_exe ${msys2_sh_exe})
	endif()
	
	if(NOT EXISTS "${sh_exe}")
		dk_fatal("sh_exe:${sh_exe} NOT FOUND")
		return()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_sh_exe()
	if(EXISTS "${sh_exe}")
		dk_success("sh_exe = ${sh_exe}")
	else()
		dk_error("sh_exe = ${sh_exe}")
	endif()
endfunction()
