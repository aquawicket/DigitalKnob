#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ libwinpthread ############
dk_load(dk_builder)
#if(WIN_X86)
#	dk_depend(mingw32)
#elseif(WIN_X86_64)
#	dk_depend(mingw64)
#endif()
dk_validate(MSYS2 "dk_depend(msys2)")

if(WIN_X86_CLANG)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/clang32/lib)
elseif(WIN_X86_64_CLANG)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/clang64/lib)
elseif(WIN_X86_MINGW)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/mingw32/lib)
elseif(WIN_X86_64_MINGW)
	dk_set(LIBWINPTHREAD ${MSYS2_DIR}/mingw64/lib)
endif()


### LINK ###
if(WIN)
	dk_libDebug(${LIBWINPTHREAD}/libwinpthread.a)
	dk_libRelease(${LIBWINPTHREAD}/libwinpthread.a)
	
### 3RDPARTY LINK ###	
	dk_set(LIBWINPTHREAD_CMAKE -DLIBWINPTHREAD_LIBRARIES=${LIBWINPTHREAD})
endif()