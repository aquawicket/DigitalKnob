include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://gcc.gnu.org/onlinedocs/gccint/Libgcc.html


if(MSYSTEM)
	dk_depend(msys2)
	#set(LIBGCC_VERSION "13.2.0")
	set(LIBGCC_VERSION "14.2.0")
	
	#if(WIN_X86)
	#	WIN_dk_libDebug(${MSYS2_DIR}/mingw32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_DEBUG)
	#	WIN_dk_libRelease(${MSYS2_DIR}/mingw32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	#elseif(WIN_X86_64)
	#	WIN_dk_libDebug(${MSYS2_DIR}/mingw64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_DEBUG)
	#	WIN_dk_libRelease(${MSYS2_DIR}/mingw64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a	LIBGCC_LIBRARY_RELEASE)
	if(win_x86_clang)
		# TODO
	elseif(win_x86_64_clang)
		# TODO
	elseif(win_arm64_clang)
		# TODO
	elseif(win_x86_mingw)
		WIN_dk_libDebug(${MSYS2_DIR}/mingw32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_DEBUG)
		WIN_dk_libRelease(${MSYS2_DIR}/mingw32/lib/gcc/i686-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	elseif(win_x86_64_mingw)
		WIN_dk_libDebug(${MSYS2_DIR}/mingw64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a		LIBGCC_LIBRARY_DEBUG)
		WIN_dk_libRelease(${MSYS2_DIR}/mingw64/lib/gcc/x86_64-w64-mingw32/${LIBGCC_VERSION}/libgcc.a	LIBGCC_LIBRARY_RELEASE)
	elseif(win_x86_64_ucrt)
		# TODO
	endif()

	### 3RDPARTY LINK ###
	WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})
	#WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES="${LIBGCC_LIBRARY_DEBUG} ${LIBGCC_LIBRARY_RELEASE}")
endif()
