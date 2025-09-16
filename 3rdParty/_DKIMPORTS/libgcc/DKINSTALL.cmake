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

dk_validate(Target_Tuple "dk_Target_Tuple()")
#if(MSYSTEM)
	dk_depend(msys2)
#	set(libgcc_Version "14.2.0")
	
	if(Windows_X86_Clang)
#		dk_libDebug(${msys2}/clang32/lib/gcc/i686-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${msys2}/clang32/lib/gcc/i686-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_RELEASE)
	elseif(Windows_X86_64_Clang)
#		dk_libDebug(${msys2}/clang64/lib/gcc/x86_64-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${msys2}/clang64/lib/gcc/x86_64-w64-mingw32/${libgcc_Version}/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	elseif(Windows_Arm64_Clang)
#		dk_libDebug(${msys2}/clangarm64/lib/gcc/aarch64-w64-mingw32/${libgcc_Version}/libgcc.a		LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${msys2}/clangarm64/lib/gcc/aarch64-w64-mingw32/${libgcc_Version}/libgcc.a	LIBGCC_LIBRARY_RELEASE)
	elseif(Windows_X86_Gcc)
		dk_libDebug(${msys2}/mingw32/lib/gcc/i686-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
		dk_libRelease(${msys2}/mingw32/lib/gcc/i686-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_RELEASE)
	elseif(Windows_X86_64_Gcc)
		dk_libDebug(${msys2}/mingw64/lib/gcc/x86_64-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
		dk_libRelease(${msys2}/mingw64/lib/gcc/x86_64-w64-mingw32/${libgcc_Version}/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	elseif(Windows_X86_64_Ucrt)
#		dk_libDebug(${msys2}/ucrt64/lib/gcc/x86_64-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${msys2}/ucrt64/lib/gcc/x86_64-w64-mingw32/${libgcc_Version}/libgcc.a			LIBGCC_LIBRARY_RELEASE)
	endif()

	### 3RDPARTY LINK ###
	if(Windows)
		dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})
		#dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES="${LIBGCC_LIBRARY_DEBUG} ${LIBGCC_LIBRARY_RELEASE}")
	endif()
#endif()
