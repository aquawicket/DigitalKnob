#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.gnu.org/software/bash/
# https://packages.msys2.org/package/bash

### Msys2 ###
if(MSYSTEM)
	#dk_command(${PACMAN_EXE} -S bash)
	dk_findProgram(BASH_EXE bash "${MSYS2_DIR}/usr/bin")
endif()


### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi bash)
	dk_findProgram(BASH_EXE bash)
	dk_debug(BASH_EXE)
endif()