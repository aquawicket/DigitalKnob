#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ wget ############
dk_load(dk_builder)

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