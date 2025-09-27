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



############# ninja binary ############
# https://github.com/ninja-build/ninja.git

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Windows_Host)
	dk_import(https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip)
	dk_findProgram(ninja_exe ninja ${ninja})
elseif(Mac_Host)
	dk_import(https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-mac.zip)
	dk_findProgram(ninja_exe ninja ${ninja})
elseif(Linux_Host)
	dk_import(https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-linux.zip)
	dk_findProgram(ninja_exe ninja ${ninja})
else()
	dk_error("Ninja not available for this host")
endif()



########### ninja source ############
#dk_import(https://github.com/ninja-build/ninja/archive/f8ce3b32.zip)
#dk_include(${ninja})
#dk_libDebug(${ninja_Debug_Dir}/ninja.exe)
#dk_libRelease(${ninja_Debug_Dir}/ninja.exe)
#dk_configure()
#dk_build()
