#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### libgcc ############
# https://gcc.gnu.org/onlinedocs/gccint/Libgcc.html

dk_validate(Target_Tuple "dk_Target_Tuple()")
#if(MSYSTEM)
	dk_validate(MSYS2 "dk_depend(msys2)")
	#set(LIBGCC_VERSION "13.2.0")
	set(LIBGCC_VERSION "14.2.0")
	
	if(win_x86_clang)
#		dk_libDebug(${MSYS2_DIR}/clang32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${MSYS2_DIR}/clang32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_RELEASE)
	elseif(Win_X86_64_Clang)
#		dk_libDebug(${MSYS2_DIR}/clang64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${MSYS2_DIR}/clang64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	elseif(win_arm64_clang)
#		dk_libDebug(${MSYS2_DIR}/clangarm64/lib/gcc/aarch64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${MSYS2_DIR}/clangarm64/lib/gcc/aarch64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a	LIBGCC_LIBRARY_RELEASE)
	elseif(win_x86_gcc)
		dk_libDebug(${MSYS2_DIR}/mingw32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
		dk_libRelease(${MSYS2_DIR}/mingw32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_RELEASE)
	elseif(win_x86_64_gcc)
		dk_libDebug(${MSYS2_DIR}/mingw64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
		dk_libRelease(${MSYS2_DIR}/mingw64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	elseif(win_x86_64_ucrt)
#		dk_libDebug(${MSYS2_DIR}/ucrt64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_DEBUG)
#		dk_libRelease(${MSYS2_DIR}/ucrt64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a			LIBGCC_LIBRARY_RELEASE)
	endif()

	### 3RDPARTY LINK ###
	if(WIN)
		dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})
		#dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES="${LIBGCC_LIBRARY_DEBUG} ${LIBGCC_LIBRARY_RELEASE}")
	endif()
#endif()
