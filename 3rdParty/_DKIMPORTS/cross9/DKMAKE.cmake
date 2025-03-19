#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### cross9 ######
# https://justine.lol/cosmopolitan/windows-compiling.html

dk_load(dk_builder)

if((NOT WIN_HOST) OR (NOT COSMOPOLITAN))
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