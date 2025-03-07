#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")



############# ninja binary ############
# https://github.com/ninja-build/ninja.git

dk_validate(host_triple "dk_host_triple()")
if(WIN_HOST)
	dk_import(https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip)
	dk_findProgram(NINJA_EXE ninja ${NINJA})
elseif(MAC_HOST)
	dk_import(https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-mac.zip)
	dk_findProgram(NINJA_EXE ninja ${NINJA})
elseif(LINUX_HOST)
	dk_import(https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip)
	dk_findProgram(NINJA_EXE ninja ${NINJA})
else()
	dk_error("Ninja not available for this host")
endif()



########### ninja source ############
#dk_import(https://github.com/ninja-build/ninja/archive/f8ce3b32.zip)
#dk_include(${NINJA})
#dk_libDebug(${NINJA_DEBUG_DIR}/ninja.exe)
#dk_libRelease(${NINJA_DEBUG_DIR}/ninja.exe)
#dk_configure(${NINJA})
#dk_build(${NINJA})
