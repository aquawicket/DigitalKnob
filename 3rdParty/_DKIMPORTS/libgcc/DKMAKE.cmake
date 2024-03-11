# https://gcc.gnu.org/onlinedocs/gccint/Libgcc.html


if(MSYSTEM)
	dk_depend(msys2)
	
	#if(WIN_X86)
	#	WIN_dk_libDebug(${MSYS2}/mingw32/lib/gcc/i686-w64-mingw32/13.2.0/libgcc.a		LIBGCC_LIBRARY_DEBUG)
	#	WIN_dk_libRelease(${MSYS2}/mingw32/lib/gcc/i686-w64-mingw32/13.2.0/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	#elseif(WIN_X86_64)
	#	WIN_dk_libDebug(${MSYS2}/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/libgcc.a		LIBGCC_LIBRARY_DEBUG)
	#	WIN_dk_libRelease(${MSYS2}/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/libgcc.a	LIBGCC_LIBRARY_RELEASE)
	if(CLANG32)
		# TODO
	elseif(CLANG64)
		# TODO
	elseif(CLANGARM64)
		# TODO
	elseif(MINGW32)
		WIN_dk_libDebug(${MSYS2}/mingw32/lib/gcc/i686-w64-mingw32/13.2.0/libgcc.a		LIBGCC_LIBRARY_DEBUG)
		WIN_dk_libRelease(${MSYS2}/mingw32/lib/gcc/i686-w64-mingw32/13.2.0/libgcc.a		LIBGCC_LIBRARY_RELEASE)
	elseif(MINGW64)
		WIN_dk_libDebug(${MSYS2}/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/libgcc.a		LIBGCC_LIBRARY_DEBUG)
		WIN_dk_libRelease(${MSYS2}/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/libgcc.a	LIBGCC_LIBRARY_RELEASE)
	elseif(UCRT64)
		# TODO
	endif()

	### 3RDPARTY LINK ###
	WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})
	#WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES="${LIBGCC_LIBRARY_DEBUG} ${LIBGCC_LIBRARY_RELEASE}")
endif()
