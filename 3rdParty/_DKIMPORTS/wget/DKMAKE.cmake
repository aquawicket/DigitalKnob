# wget

### Msys2 ###
if(MSYSTEM)
	#dk_command(pacman -S wget)
	dk_findProgram(WGET_EXE bash "${MSYS2}/usr/bin")
endif()


### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi wget)
	dk_findProgram(WGET_EXE wget)
	dk_debug(WGET_EXE)
endif()