#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libmingwex ############
dk_load(dk_builder)
dk_validate(MSYS2 "dk_depend(msys2)")

if(WIN_X86_CLANG)
	dk_set(LIBMINGWEX ${MSYS2_DIR}/clang32/lib)
endif()
if(WIN_X86_64_CLANG)
	dk_set(LIBMINGWEX ${MSYS2_DIR}/clang64/lib)
endif()
if(WIN_X86_GCC)
	dk_set(LIBMINGWEX ${MSYS2_DIR}/mingw32/lib)
endif()
if(WIN_X86_64_GCC)
	dk_set(LIBMINGWEX ${MSYS2_DIR}/mingw64/lib)
endif()


### LINK ###
if(WIN)
	dk_libDebug(${LIBMINGWEX}/libmingwex.a)
	dk_libRelease(${LIBMINGWEX}/libmingwex.a)
endif()

### 3RDPARTY LINK ###
if(WIN)
	dk_set(LIBMINGWEX_CMAKE -DLIBMINGWEX_LIBRARIES=${LIBMINGWEX})
endif()