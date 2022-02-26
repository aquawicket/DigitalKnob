if(NOT WIN_HOST)
	return()
endif()


DKSET(MINGW32_VERSION 8.1.0)
DKSET(MINGW32_DL https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/8.1.0/threads-posix/dwarf/i686-8.1.0-release-posix-dwarf-rt_v6-rev0.7z)
DKSET(MINGW32_NAME mingw32-${MINGW32_VERSION})
DKSET(MINGW32 ${3RDPARTY}/${MINGW32_NAME})
DKINSTALL(${MINGW32_DL} mingw32 ${MINGW32})
