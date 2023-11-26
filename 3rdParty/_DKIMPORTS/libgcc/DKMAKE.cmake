#if(WIN_32)
#	dk_depend(mingw32)
#elseif(WIN_64)
#	dk_depend(mingw64)
#endif()
dk_depend(msys2)


dk_set(LIBGCC_NAME libgcc)
if(WIN_32)
	#dk_set(LIBGCC ${MINGW32}/lib/gcc/i686-w64-mingw32/8.1.0)
	dk_set(LIBGCC ${MSYS2}/mingw32/lib/gcc/i686-w64-mingw32/12.2.0)
endif()
if(WIN_64)
	#dk_set(LIBGCC ${MINGW64}/lib/gcc/x86_64-w64-mingw32/8.1.0)
	dk_set(LIBGCC ${MSYS2}/mingw64/lib/gcc/x86_64-w64-mingw32/12.2.0)
endif()


### LINK ###
WIN_dk_libDebug(${LIBGCC}/libgcc.a)
WIN_dk_libRelease(${LIBGCC}/libgcc.a)


### 3RDPARTY LINK ###
WIN_dk_set(LIBGCC_CMAKE -DLIBGCC_LIBRARIES=${LIBGCC})


# fatal error LNK1104: cannot open file 'C:\Users\Administrator\digitalknob\DK\3rdParty\mingw32-i686-8.1.0-release-posix-dwarf-rt_v6-rev0\lib\gcc\i686-w64-mingw32\i686-8.1.0-release-posix-dwarf-rt_v6-rev0\libgcc.a'