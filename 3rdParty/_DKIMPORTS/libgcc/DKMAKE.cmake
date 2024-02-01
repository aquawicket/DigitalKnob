dk_depend(msys2)

dk_set(LIBGCC_NAME libgcc)
if(WIN_32)
	dk_set(LIBGCC  ${MSYS2}/mingw32/lib/gcc/x86_64-w64-mingw32/13.2.0)
endif()
if(WIN_64)
	dk_set(LIBGCC  ${MSYS2}/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0)
endif()


### LINK ###
WIN_dk_libDebug(${LIBGCC}/libgcc.a)
WIN_dk_libRelease(${LIBGCC}/libgcc.a)


### 3RDPARTY LINK ###
WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})