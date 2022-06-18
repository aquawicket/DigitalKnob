if(WIN_32)
	dk_depend(mingw32)
elseif(WIN_64)
	dk_depend(mingw64)
endif()


dk_set(LIBGCC_NAME libgcc)
if(WIN_32)
	dk_set(LIBGCC ${MINGW32}/lib/gcc/i686-w64-mingw32/${MINGW32_VERSION})
endif()
if(WIN_64)
	dk_set(LIBGCC ${MINGW64}/lib/gcc/x86_64-w64-mingw32/${MINGW32_VERSION})
endif()


### LINK ###
WIN_DEBUG_DKLIB(${LIBGCC}/libgcc.a)
WIN_RELEASE_DKLIB(${LIBGCC}/libgcc.a)
#WIN32_DEBUG_DKLIB(${MINGW32}/lib/gcc/i686-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
#WIN32_RELEASE_DKLIB(${MINGW32}/lib/gcc/i686-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
#WIN64_DEBUG_DKLIB(${MINGW64}/lib/gcc/x86_64-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
#WIN64_RELEASE_DKLIB(${MINGW64}/lib/gcc/x86_64-w64-mingw32/${MINGW32_VERSION}/libgcc.a)


### 3RDPARTY LINK ###
WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})
