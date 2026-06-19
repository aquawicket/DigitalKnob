#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ libwinpthread ############

dk_validate(msys2 "dk_depend(msys2)")

if(Windows_X86_Clang)
	dk_set(libwinpthread ${msys2}/clang32/lib)
elseif(Windows_X86_64_Clang)
	dk_set(libwinpthread ${msys2}/clang64/lib)
elseif(Windows_X86_Gcc)
	dk_set(libwinpthread ${msys2}/mingw32/lib)
elseif(Windows_X86_64_Gcc)
	dk_set(libwinpthread ${msys2}/mingw64/lib)
endif()

if(Windows)
	dk_libDebug("${libwinpthread}/libwinpthread.a")
	dk_libRelease("${libwinpthread}/libwinpthread.a")
	
	dk_set(libwinpthread_CMAKE -DLIBWINPTHREAD_LIBRARIES=${libwinpthread})
endif()
