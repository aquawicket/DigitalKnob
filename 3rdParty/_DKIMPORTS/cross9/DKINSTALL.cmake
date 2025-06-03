#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### cross9 ######
# https://justine.lol/cosmopolitan/windows-compiling.html

dk_validate(Config_Path  "dk_Config_Path()")

if((NOT Windows_Host) OR (NOT Cosmopolitan))
	dk_undepend(cross9)
	dk_return()
endif()


dk_import(https://justine.lol/linux-compiler-on-windows/cross9.zip)

#dk_set(CROSS9_DL https://justine.lol/linux-compiler-on-windows/cross9.zip)
#dk_importVariables(${CROSS9_DL})


#if(NOT EXISTS ??)
#	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
#	dk_echo("Installing ${CROSS9_FOLDER}")
	
	### Download ###
#	dk_download(${CROSS9_DL} $ENV{DKDOWNLOAD_DIR})


#endif()