include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# wget

### Msys2 ###
if(MSYSTEM)
	#dk_command(${PACMAN_EXE} -S wget --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
	dk_findProgram(WGET_EXE bash "${MSYS2_DIR}/usr/bin")
endif()


### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi wget)
	dk_findProgram(WGET_EXE wget)
	dk_debug(WGET_EXE)
endif()