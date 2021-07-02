### VERSION ###
if(WIN_32)
	DKDEPEND(mingw32)
elseif(WIN_64)
	DKDEPEND(mingw32)
endif()


### LINK ###
WIN32_DEBUG_LIB(${MINGW32_VS}/lib/gcc/i686-w64-mingw32/4.9.2/libgcc.a)
WIN32_RELEASE_LIB(${MINGW32_VS}/lib/gcc/i686-w64-mingw32/4.9.2/libgcc.a)
WIN64_DEBUG_LIB(${MINGW64_VS}/lib/gcc/x86_64-w64-mingw32/4.9.2/libgcc.a)
WIN64_RELEASE_LIB(${MINGW64_VS}/lib/gcc/x86_64-w64-mingw32/4.9.2/libgcc.a)
