# https://www.gnu.org/software/bash/
# https://packages.msys2.org/package/bash

### Msys2 ###
if(MSYSTEM)
	#dk_command(pacman -S bash)
	dk_findProgram(BASH_EXE bash "${MSYS2}/usr/bin")
endif()


### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi bash)
	dk_findProgram(BASH_EXE bash)
	dk_debug(BASH_EXE)
endif()