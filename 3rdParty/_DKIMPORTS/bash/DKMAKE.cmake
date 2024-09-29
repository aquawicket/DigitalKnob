#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://www.gnu.org/software/bash/
# https://packages.msys2.org/package/bash

### Msys2 ###
if(WIN_HOST)
	if(MSYSTEM)
		dk_depend(msys)
		#dk_command(${PACMAN_EXE} -S bash)
		dk_findProgram(BASH_EXE bash "${MSYS2_DIR}/usr/bin")
	else()
		dk_depend(git)
		dk_findProgram(BASH_EXE bash "${GIT}/bin")
	endif()
endif()


### Tiny Core Linux ###
if(TINYCORE)
	dk_command(tce-load -wi bash)
endif()


dk_findProgram(BASH_EXE bash)
dk_assertPath(${BASH_EXE})