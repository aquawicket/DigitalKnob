#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ libwinpthread ############
dk_load(dk_builder)

dk_validate(MSYS2 "dk_depend(msys2)")

if(Win_X86_Clang)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/clang32/lib)
elseif(Win_X86_64_Clang)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/clang64/lib)
elseif(Win_X86_Gcc)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/mingw32/lib)
elseif(Win_X86_64_Gcc)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/mingw64/lib)
endif()


### LINK ###
if(WIN)
	dk_libDebug(${LIBWINPTHREAD}/libwinpthread.a)
	dk_libRelease(${LIBWINPTHREAD}/libwinpthread.a)
	
### 3RDPARTY LINK ###	
	dk_set(LIBWINPTHREAD_CMAKE -DLIBWINPTHREAD_LIBRARIES=${LIBWINPTHREAD})
endif()