### VERSION ###
if(WIN_32)
	DKDEPEND(mingw32)
elseif(WIN_64)
	DKDEPEND(mingw64)
endif()


### LINK ###
WIN32_DEBUG_LIB(${MINGW32}/lib/gcc/i686-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
WIN32_RELEASE_LIB(${MINGW32}/lib/gcc/i686-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
WIN64_DEBUG_LIB(${MINGW64}/lib/gcc/x86_64-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
WIN64_RELEASE_LIB(${MINGW64}/lib/gcc/x86_64-w64-mingw32/${MINGW32_VERSION}/libgcc.a)
