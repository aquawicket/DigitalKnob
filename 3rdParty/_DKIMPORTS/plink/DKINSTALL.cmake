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


############ plink ############
# https://www.chiark.greenend.org.uk/~sgtatham/putty
# https://the.earth.li/~sgtatham/putty/latest/wa64/plink.exe
# https://the.earth.li/~sgtatham/putty/latest/w32/plink.exe
# https://the.earth.li/~sgtatham/putty/latest/w64/plink.exe

dk_import()
dk_set(plink_exe "${plink}/plink.exe")
dk_copy("${dk_download}" "${plink_exe}")
