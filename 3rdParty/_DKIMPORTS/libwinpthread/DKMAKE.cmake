#if(WIN_X86)
#	dk_depend(mingw32)
#elseif(WIN_64)
#	dk_depend(mingw64)
#endif()
dk_depend(msys2)


if(WIN_X86)
	#dk_set(LIBWINPTHREAD ${MINGW32}/i686-w64-mingw32/lib)
	dk_set(LIBWINPTHREAD ${MSYS2}/mingw32/lib)
endif()
if(WIN_64)
	#dk_set(LIBWINPTHREAD ${MINGW64}/x86_64-w64-mingw32/lib)
	dk_set(LIBWINPTHREAD ${MSYS2}/mingw64/lib)
endif()


### LINK ###
WIN_dk_libDebug(${LIBWINPTHREAD}/libwinpthread.a)
WIN_dk_libRelease(${LIBWINPTHREAD}/libwinpthread.a)


### 3RDPARTY LINK ###
WIN_dk_set(LIBWINPTHREAD_CMAKE -DLIBWINPTHREAD_LIBRARIES=${LIBWINPTHREAD})
