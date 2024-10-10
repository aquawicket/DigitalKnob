#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# wget



dk_installPackage(wget)


### Msys2 ###
if(MSYSTEM)
	#dk_command(${PACMAN_EXE} -S wget --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
	dk_findProgram(WGET_EXE wget "${MSYS2_DIR}/usr/bin")
endif()

### Tiny Core Linux ###
if(TINYCORE)
	#dk_command(tce-load -wi wget)
	dk_findProgram(WGET_EXE wget)
endif()