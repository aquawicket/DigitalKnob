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


########### libgcc ############
# https://gcc.gnu.org/onlinedocs/gccint/Libgcc.html

dk_validate(msys2 "dk_depend(msys2)")

###### libgcc_Path ######
	if(Windows_Arm64_Clang)
	set(libgcc_Path "${msys2}/clangarm64/lib/gcc/aarch64-w64-mingw32")
elseif(Windows_X86_Clang)
	set(libgcc_Path "${msys2}/clang32/lib/gcc/i686-w64-mingw32")
elseif(Windows_X86_Gcc)
	set(libgcc_Path "${msys2}/mingw32/lib/gcc/i686-w64-mingw32")
elseif(Windows_X86_64_Clang)
	set(libgcc_Path "${msys2}/clang64/lib/gcc/x86_64-w64-mingw32")
elseif(Windows_X86_64_Gcc)
	set(libgcc_Path "${msys2}/mingw64/lib/gcc/x86_64-w64-mingw32")
elseif(Windows_X86_64_Ucrt)
	set(libgcc_Path "${msys2}/ucrt64/lib/gcc/x86_64-w64-mingw32")
endif()
dk_debug("libgcc_Path = ${libgcc_Path}")

###### libgcc_Version ######
macro(libgcc_Version)
	file(GLOB children RELATIVE "${libgcc_Path}" "${libgcc_Path}/*")
	foreach(child ${children})
		if(EXISTS "${libgcc_Path}/${child}/libgcc.a")
			dk_set(libgcc_Version ${child})
			break()
		endif()
	endforeach()
	if(NOT libgcc_Version)
		dk_warning("libgcc_Version(): Could not locate version. Defaulting to 14.2.0")
		set(libgcc_Version "14.2.0") # DEFAULT
	endif()
endmacro()
if(NOT libgcc_Version)
	libgcc_Version()
endif()
dk_debug("libgcc_Version = ${libgcc_Version}")

###### libgcc ######
dk_set(libgcc "${libgcc_Path}/${libgcc_Version}")
dk_debug("libgcc = ${libgcc}")

###### LIBGCC_LIBRARY ######
dk_set(LIBGCC_LIBRARY "${libgcc_Path}/${libgcc_Version}/libgcc.a")
dk_debug("LIBGCC_LIBRARY = ${LIBGCC_LIBRARY}")

if(EXISTS ${LIBGCC_LIBRARY})
	###### LIBGCC_LIBRARY_DEBUG ######
	dk_libDebug(${LIBGCC_LIBRARY}	LIBGCC_LIBRARY_DEBUG)
	###### LIBGCC_LIBRARY_RELEASE ######
	dk_libRelease(${LIBGCC_LIBRARY}	LIBGCC_LIBRARY_RELEASE)

	if(Windows)
		###### libgcc_CMAKE ######
		dk_set(libgcc_CMAKE -DLIBGCC_LIBRARIES=${libgcc})
		#dk_set(libgcc_CMAKE -DLIBGCC_LIBRARIES="${LIBGCC_LIBRARY_DEBUG} ${LIBGCC_LIBRARY_RELEASE}")
	endif()
endif()

