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


############ libmingwex ############
dk_validate(Target_Config  "dk_Target_Config()")
dk_depend(msys2)

if(Windows_X86_Clang)
	dk_set(LIBMINGWEX ${msys2}/clang32/lib)
endif()
if(Windows_X86_64_Clang)
	dk_set(LIBMINGWEX ${msys2}/clang64/lib)
endif()
if(Windows_X86_Gcc)
	dk_set(LIBMINGWEX ${msys2}/mingw32/lib)
endif()
if(Windows_X86_64_Gcc)
	dk_set(LIBMINGWEX ${msys2}/mingw64/lib)
endif()


### LINK ###
if(Windows)
	dk_libDebug(${LIBMINGWEX}/libmingwex.a)
	dk_libRelease(${LIBMINGWEX}/libmingwex.a)
endif()

### 3RDPARTY LINK ###
if(Windows)
	dk_set(LIBMINGWEX_CMAKE -DLIBMINGWEX_LIBRARIES=${LIBMINGWEX})
endif()